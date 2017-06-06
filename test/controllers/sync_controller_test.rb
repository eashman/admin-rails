require 'test_helper'

class SyncControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sync_index_url
    assert_response :success
  end

end
