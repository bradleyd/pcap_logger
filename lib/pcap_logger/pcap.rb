require "pcaplet"
module PcapLogger
  # pcap is a wrapper around ruby-pcap
  #
  # @param  [Hash] snaplen
  # @param  [Hash] pkt_count
  # @param  [Hash] device
  # @return [Object] PcapLogger::Pcap
  class Pcap
    attr_accessor :pcaplet
    attr_reader :device
    def initialize(args={})
      snaplen     = args.fetch(:snaplen)
      pkt_count   = args.fetch(:pkt_count)
      dev         = args.fetch(:device) { "-i #{self.device}" }
      @pcaplet = Pcaplet.new(self.create_commands(args.values))
    end

    def device
      pcaplet.instance_variable_get(:@device)
    end

    # builds command string to be passed to Pcaplet.new
    #
    # @param  [Array]args
    # @return [String] commands serparated by spaces
    # @example -s 1500 -c 10 -i eth0
    def create_commands args
      command = String.new
      args.each do |arg|
        command << arg << " " 
      end
      command
    end
  end
end
