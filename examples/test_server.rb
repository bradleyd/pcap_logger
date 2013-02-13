#!/usr/bin/ruby
require 'eventmachine'
require 'socket'
require 'date'
require 'fileutils'
require 'singleton'

class Writers
  include Singleton

  def initialize
    @fd = {}
    @count = {}
    @conn = {}
  end

  def add_conn(port,peer)
    @fd[port] = peer
    return @fd
  end

  def open(date,snaplen,peer,port)
    header= [
      0xd4, 0xc3, 0xb2, 0xa1, # magic number
      0x02, 0x00, 0x04, 0x00, # version number
      0x00, 0x00, 0x00, 0x00, # gmt to local
      0x00, 0x00, 0x00, 0x00, # accuracy of timestamps
    ]
    header += [snaplen].pack("I1").unpack("C4")
    header += [
      0x01, 0x00, 0x00, 0x00,         # data link type
    ]
    begin
      @conn[port] = peer #unless @conn.has_key?(port) #add to hash 
      @fd.each do |k,v|
        if v.closed?
          @conn.delete(k)
        end
      end
      peer = peer+".#{port}" if  @conn.select {|k,v| v==peer}.length > 1

      if not FileTest.exist?("#{date}/#{peer}.dmp")
        @fd[port] =File.open("#{date}/#{peer}.dmp",'w') 
        @fd[port].write(header.pack("C24"))
        @fd[port].close
      end
      @fd[port] = File.open("#{date}/#{peer}.dmp",'a') 
      puts "re-opened file "
      @count[port] ||= 0
      @count[port] += 1
    rescue Errno::ENOENT => e
      FileUtils.mkdir(date)
      retry
    end
  end
  def close(port)
    @count[port] -= 1
    @fd[port].close if @count[port] <= 0
  end
  def [](port)
    @fd[port]
  end
end

$enter = 0
module WriteToFile

  def post_init
    pn = self.get_peername
    @writers=Writers.instance
    @irc_port, @peer = pn ? Socket.unpack_sockaddr_in(pn) : [0, "?.?.?.?"]
    @who = []
    @stamp = Time.now.strftime("%Y-%m-%d")
    @snaplen = 1500
    @writers.open(@stamp,@snaplen,@peer,@irc_port)
  end

  def receive_data(data)
    @ndate = Time.now.strftime("%Y-%m-%d")
    bool = (not @ndate == @stamp)
    if  bool
      @stamp = @ndate
      puts "closing for some strange reason"
      @writers.close(@irc_port)
      @writers.open(@ndate,@snaplen,@peer,@irc_port)
    end
    @writers[@irc_port].write(data)
  end
  def unbind
    @writers.close(@irc_port)
  end

end

EM.run {
  EM.start_server "0.0.0.0", 20000, WriteToFile
}

