require 'test_helper'

class JournalsControllerTest < ActionDispatch::IntegrationTest

  test "#index" do
    get journals_path

    assert_response :success
  end
end
