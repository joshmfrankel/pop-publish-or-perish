require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest

  test "GET #home succeeds" do
    get home_path

    assert_response :success
  end
end
