require "pcaplet"

module PcapLogger
  # pcap_filter create filter object
  #
  # @param  [Hash] filter
  # @param  [Hash] pcap_object
  # @return [Object] PcapLogger::PcapFilter
  class PcapFilter
    attr_accessor :packet_filter
    def initialize(options={})
      filter = options.fetch(:filter)
      pcap_obj = options.fetch(:pcap_object)
      @packet_filter = ::Pcap::Filter.new(filter, pcap_obj.capture)
    end

  end
end
