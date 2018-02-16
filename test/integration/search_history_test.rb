require 'test_helper'

class SearchHistoryTest < ActionDispatch::IntegrationTest
  test "can see my search history" do
    get "/search_history"
    assert_select "h2", "Search History"
  end
end
