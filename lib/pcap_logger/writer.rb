require "socket"
module PcapLogger
  # writes raw packet so a socket (EM.server)
  #
  # @param  [Hash] args
  #
  class Writer
    attr_reader :socket_server, :host, :port
    def initialize(args)
      @host = args.fetch(:host) { "localhost" }
      @port = args.fetch(:port) { 20000 }
      connect
    end

    # open socket to socket server
    def connect
      begin
        @socket_server = TCPSocket.open(@host, @port.to_i)
      rescue Errno::ECONNREFUSED => e
        raise PcapLogger::SocketWriterException.new("Cannot connect to host: #{@host} on port: #{@port}")
      end
    end

    # actually pushes packets to a socket
    #
    # f.write([pkt.time_i, pkt.time.tv_usec, length, pkt.length].pack("I4"))
    # f.write pkt.raw_data 
    # f.flush
    # @param  [String] packet raw pcap packet
    # @return [nil]
    def push packet
      begin
        @socket_server.write packet
      rescue Errno::ECONNRESET => e
        p e.message
        close
        reset_connection
      rescue Errno::EPIPE => e
        p e.message
        close
        reset_connection
      rescue Errno::ECONNREFUSED => e
        p e.message
        close
        reset_connection
      end
    end

    # close socket connection
    def close
      @socket_server.close
    end

    # reset the socket connection to the server
    def reset_connection
      #close if 
      @socket_server = nil
      connect
    end
  end
  
end
