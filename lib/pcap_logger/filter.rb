require "pcaplet"

module PcapLogger
  attr_accessor :packet_filter
  class PcapFilter
    def initialize(options={})
      filter = options.fetch(:filter)
      pcap_obj = options.fetch(:pcap_object)
      @packet_filter = ::Pcap::Filter.new(filter, pcap_obj.capture)
    end

    def packet_filter
      @packet_filter
    end

  end
end
