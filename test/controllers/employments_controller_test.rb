require 'test_helper'

class EmploymentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get employments_index_url
    assert_response :success
  end

end
