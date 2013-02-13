require_relative 'test_helper'

class TestPcapLogger < MiniTest::Unit::TestCase

  def setup
    @pkt_count = 10
    @pc = PcapLogger::Pcap.new(snaplen: '-s 1500', pkt_count: "-c #{@pkt_count}")
  end

  def test_that_there_is_device
   assert_equal "eth0", @pc.device
  end

  def test_pcap_capture_method
    assert_respond_to(@pc.pcaplet, :capture)
  end

  def test_pcap_creates_a_filter
    filter = PcapLogger::PcapFilter.new(filter: 'tcp port 80', pcap_object: @pc.pcaplet)
    assert_respond_to(filter, :packet_filter)
  end

  def test_packet_capture
    packets = []
    filter = PcapLogger::PcapFilter.new(filter: 'tcp port 80', pcap_object: @pc.pcaplet)
    @pc.pcaplet.add_filter(filter.packet_filter)
    @pc.pcaplet.each_packet { |pkt|
      packets << pkt

    }
    @pc.pcaplet.close
    assert_equal(packets.size, @pkt_count)
  end
end
