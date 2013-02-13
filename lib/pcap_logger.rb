require_relative "pcap_logger/version"
require_relative "pcap_logger/pcap"
require_relative "pcap_logger/filter"
require_relative "pcap_logger/writer"
require_relative "pcap_logger/exceptions"

module PcapLogger

  # start--this is where the magic happens
  #
  # @todo this is large method and should be broken up
  # @param  [Hash] options from the command line-- see bin/pcap_logger
  # @return [nil] when finished or if you hit CTRL-C
  def self.start(options={})
     trap('INT') do
      stop()
      raise(SignalException,'INT',caller)
    end

    # fetch options @see bin/pcap_logger
    snaplen     = options.fetch(:snaplen) 
    pkt_count   = options.fetch(:pkt_count) 
    device      = options.fetch(:device) 
    filter      = options.fetch(:filter)
    remote_port = options.fetch(:remote_port) { 20000 }
    remote_host = options.fetch(:remote_host)

    @pc     = PcapLogger::Pcap.new(snaplen: snaplen, pkt_count: pkt_count)
    filter  = PcapLogger::PcapFilter.new(filter: filter, pcap_object: @pc.pcaplet)
    @pc.pcaplet.add_filter(filter.packet_filter)
    writer  = PcapLogger::Writer.new(host: remote_host, port: remote_port)
    
    p @pc

    @pc.pcaplet.each_packet { |pkt|
      length=pkt.length
      length=pkt.caplen if length > pkt.caplen
      writer.push [pkt.time_i, pkt.time.tv_usec, length, pkt.length].pack("I4")
      writer.push pkt.raw_data
      writer.socket_server.flush
    }
    @pc.pcaplet.close
  end

  # close the pacp sniffer and exit
  def self.stop
    @pc.pcaplet.close
    exit
  end
    
end
