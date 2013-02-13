require "pcaplet"

module PcapLogger
  attr_reader :pcaplet
  class Pcap
  
    def self.new(args)
      snaplen = args.fetch(:snaplen)
      obj = self.allocate
      obj.send :initialize
      @pcaplet=Pcaplet.new(snaplen)
      obj.instance_variable_set(:@pcaplet, @pcaplet)
      obj
    end

    def pcaplet
      @pcaplet
    end


    def self.device
      ::Pcap.lookupdev
    end
  end
end
