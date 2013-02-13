require File.dirname(__FILE__) + '/spec_helper.rb'

describe PcapLogger do
  it "should return back device" do
    device = PcapLogger::Pcap.device
    device.should eq("eth0")
  end

  it "should respond to capture" do
    sip_dump = PcapLogger::Pcap.new(snaplen: '-s 1500')
    sip_dump.pcaplet.should respond_to(:capture)
  end

  it "should creat a pcap filter" do
    sip_dump = PcapLogger::Pcap.new(snaplen: '-s 1500')
    filter   = PcapLogger::PcapFilter.new(filter: 'tcp port 80', pcap_object: sip_dump.pcaplet)
    filter.should respond_to(:pcap_filter)
  end

  #it "should captue packets from interface" do
    #sip_dump = PcapLogger::Pcap.new('-s 1500')
    #filter   = PcapLogger::PcapFilter.new('port 5060', sip_dump.capture)
    #sip_dump.add_filter(filter)
    #sip_dump.each_packet { |pkt|
      #byte_string = ""
      #pkt.raw_data.each_byte do |byte|
        #byte_string << sprintf("%02x ", byte)
      #end
      #p byte_string
      #length=pkt.length
      #length=pkt.caplen if length > pkt.caplen
    #}
  #end
end
