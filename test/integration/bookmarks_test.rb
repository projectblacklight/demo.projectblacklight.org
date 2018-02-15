require 'test_helper'

class BookmarksTest < ActionDispatch::IntegrationTest
  test "can see my bookmarks" do
    get "/bookmarks"
    assert_select "h1", "Bookmarks"
  end
end
