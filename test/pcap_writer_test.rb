require_relative 'test_helper'

class TestPcapiWriter < MiniTest::Unit::TestCase

  def setup
    @skt = PcapLogger::Writer.new(host: 'localhost', 
                                  port: 20000)
  end

  def test_connect_to_socket
    assert_equal(@skt.socket_server.closed?, false)
    @skt.socket_server.close
  end

  def test_connect_closes
    @skt.socket_server.close
    assert_equal(@skt.socket_server.closed?, true)
  end

end
