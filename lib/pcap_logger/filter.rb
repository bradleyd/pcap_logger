require "pcaplet"

module PcapLogger
  attr_reader :pcap_filter
  class PcapFilter
    
    def self.new(options={})
      @filter   = options.fetch(:filter)
      @pcap_obj = options.fetch(:pcap_object)
      obj = self.allocate
      obj.send :initialize
      @pcap_filter=::Pcap::Filter.new(@filter, @pcap_obj.capture)
      obj.instance_variable_set(:@pcap_filter, @pcap_filter)
      obj
    end

    def pcap_filter
      @pcap_filter
    end

  end
end
