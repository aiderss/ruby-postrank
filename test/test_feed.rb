require 'test/unit'
require 'postrank'

include PostRank

class FeedTest < Test::Unit::TestCase
  def test_get_feed
    f = create_feed

    assert_not_nil f
    assert f.is_a?(Feed)
    assert_equal f.url, "everburning.com"
  end

  def test_invalid_feed
    assert_raise Exception do create_feed("blahblahblah.com") end
  end

  def test_get_entries
    entries = create_feed.entries

    assert_not_nil entries
    assert entries.is_a?(Array)
    assert (entries.length > 0)
    assert entries.first.is_a?(Entry)
  end

  def test_get_entries_invalid_feed
    assert_raise Exception do create_feed("blahblahlbha").entries end
  end

  def test_gets_two_entries
    assert_equal 2, create_feed.entries(:count => 2).length
  end

  def test_starts_entries_at_index
    f = create_feed

    e = f.entries(:count => 4)
    e.shift  # pop the first two items so we start where e2 will start
    e.shift

    e2 = f.entries(:count => 2, :start => 2)

    assert_equal e[0].original_link, e2[0].original_link
    assert_equal e[1].original_link, e2[1].original_link
  end

  private
  def create_server(app='com.everburning', opts={})
    Server.new(app, {:server => 'api.postrank.com', :port => 80}.merge(opts))
  end

  def create_feed(feed='everburning.com')
    create_server.feed(feed)
  end
end

