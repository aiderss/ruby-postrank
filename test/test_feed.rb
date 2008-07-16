require 'test/unit'
require 'postrank'

include PostRank

class FeedTest < Test::Unit::TestCase
  def test_get_feed
    f = Server.new("com.everburning").feed("everburning.com")

    assert_not_nil f
    assert f.is_a?(Feed)
    assert_equal f.url, "everburning.com"
  end

  def test_invalid_feed
    assert_raise Exception do Server.new("com.everburning").feed("blahblahblah.com") end
  end

  def test_get_entries
    f = Server.new("com.everburning").feed("everburning.com")
    entries = f.entries

    assert_not_nil entries
    assert entries.is_a?(Array)
    assert (entries.length > 0)
    assert entries.first.is_a?(Entry)
  end

  def test_get_entries_invalid_feed
    assert_raise Exception do Server.new("com.everburning").feed("blahblahlbha").entries end
  end

  def test_gets_two_entries
    f = Server.new("com.everburning").feed("everburning.com")
    entries = f.entries(Level::ALL, 2)

    assert_equal 2, entries.length
  end

  def test_starts_entries_at_index
    f = Server.new("com.everburning").feed("everburning.com")
    e = f.entries(Level::ALL, 4)
    e.shift  # pop the first two items so we start where e2 will start
    e.shift

    e2 = f.entries(Level::ALL, 2, 2)

    assert_equal e[0].original_link, e2[0].original_link
    assert_equal e[1].original_link, e2[1].original_link
  end
end

