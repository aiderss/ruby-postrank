require 'test/unit'
require 'postrank'

include PostRank

class ServerTest < Test::Unit::TestCase
  def test_new_server
    assert_not_nil create_server
    assert_not_nil Server.new("com.everburning", :server => 'here.com')
    assert_not_nil Server.new("com.everburning", :port => 443)

    s = Server.new("com.everburning", :server => 'here.com', :port => 443)
    assert_not_nil s
    assert_equal 443, s.port
    assert_equal 'here.com', s.server
    assert_equal 'com.everburning', s.app_key
  end

  def test_new_server_with_invalid_server
    assert_raise Exception do Server.new("com.everburning", :server => 'alskdfj') end
    assert_raise Exception do Server.new("com.everburning", :server => 'http:/asdf') end
    assert_raise Exception do Server.new("com.everburning", :server => 'http://foo') end
    assert_raise Exception do Server.new("com.everburning", :server => nil) end
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
    assert_raise Exception do Server.new("com.everburning", :port => nil) end
  end

  def test_api_version
    assert_equal Server.api_version, "v1"
  end

  def test_empty_urls
    s = create_server

    assert_equal 0, s.post_rank.length
    assert_equal 0, s.post_rank([]).length
  end

  def test_post_rank
    ret = create_server.post_rank(['http://everburning.com/news/on-recent-media/',
                                   'http://everburning.com/news/californication/',
                                   'http://everburning.com/news/the-weary-traveler/'])
   
    assert_not_nil ret
    assert ret.is_a?(Array)
    assert_equal 3, ret.length
    assert ret.first.is_a?(Entry)
  end

  def test_post_rank_bad_urls
    assert_raise Exception do create_server.post_rank(['asd']) end
    assert_raise Exception do create_server.post_rank([1234]) end
    assert_raise Exception do create_server.post_rank([nil]) end

    assert_raise Exception do create_server.post_rank(['foo.com'], :feeds => [1234]) end
    assert_raise Exception do create_server.post_rank(['foo.com'], :feeds => ['asdf']) end
    assert_raise Exception do create_server.post_rank(['foo.com'],
                                            :feeds => [Feed.new(nil, nil, nil, nil)]) end
  end

  def test_feed
    f = create_server.feed("http://everburning.com")
    assert_not_nil f
    assert f.is_a?(Feed)
    assert f.feed_id > 0
    assert_equal "http://everburning.com", f.link
  end

  def test_bad_feed
    assert_raise Exception do create_server.feed(1234) end
    assert_raise Exception do create_server.feed('asdf') end
    assert_raise Exception do create_server.feed(nil) end
  end

  private
  def create_server(app='com.everburning', opts={})
    Server.new(app, {:server => 'api.postrank.com', :port => 80}.merge(opts))
  end
end

