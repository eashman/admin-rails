require 'test_helper'

class ViewerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get viewer_index_url
    assert_response :success
  end

end
