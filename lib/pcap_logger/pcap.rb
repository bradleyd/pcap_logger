require "pcaplet"
module PcapLogger
  class Pcap
    attr_accessor :pcaplet
    attr_reader :device
    def initialize(args={})
      snaplen     = args.fetch(:snaplen) { '-s 1500' }
      pkt_count   = args.fetch(:pkt_count) { '-c -1' }
      @pcaplet = Pcaplet.new(self.create_commands(args.values))
    end

    def device
      pcaplet.instance_variable_get(:@device)
    end

    def create_commands args
      command = String.new
      args.each do |arg|
        command << arg << " " 
      end
      command
    end
  end
end
