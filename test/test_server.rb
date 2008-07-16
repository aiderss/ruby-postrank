require 'test/unit'
require 'postrank'

include PostRank

class ServerTest < Test::Unit::TestCase
  def test_new_server
    assert_not_nil Server.new("com.everburning")
    assert_not_nil Server.new("com.everburing", :server => 'here.com')
    assert_not_nil Server.new("com.everburning", :port => 443)
  end

  def test_new_server_with_invalid_server
    assert_raise Exception do Server.new("com.everburning", :server => 'alskdfj') end
    assert_raise Exception do Server.new("com.everburning", :server => 'http:/asdf') end
    assert_raise Exception do Server.new("com.everburning", :server => 'http://foo') end
  end

  def test_new_server_with_invalid_application_name
    assert_raise Exception do Server.new(nil) end
    assert_raise Exception do Server.new(1234) end
    assert_raise Exception do Server.new("") end
  end

  def test_new_server_with_invalid_port
    assert_raise Exception do Server.new("com.everburning", :port => "asdf") end
    assert_raise Exception do Server.new("com.everburning", :port => -1) end
    assert_raise Exception do Server.new("com.everburning", :port => 65536) end
  end

  def test_api_version
    assert_equal Server.api_version, "v1"
  end

  def test_empty_urls
    s = Server.new("com.everburning")

    assert_equal 0, s.post_rank.length
    assert_equal 0, s.post_rank([]).length
  end

  def test_post_rank
    s = Server.new("com.everburning")
    ret = s.post_rank(['http://everburning.com/news/on-recent-media/',
                       'http://everburning.com/news/californication/',
                       'http://everburning.com/news/the-weary-traveler/'])
   
    assert_not_nil ret
    assert ret.is_a?(Array)
    assert_equal 3, ret.length
    assert ret.first.is_a?(Entry)
  end
end

