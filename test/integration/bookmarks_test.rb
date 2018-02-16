require 'test_helper'

class BookmarksTest < ActionDispatch::IntegrationTest
  test "can see my bookmarks" do
    get "/bookmarks"
    assert_select "h2", "Bookmarks"
  end
end
