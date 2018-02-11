require 'test_helper'

class AcademicsControllerTest < ActionDispatch::IntegrationTest

  test "POST #create" do
    name = "Josh"
    email = "admin@example.com"
    password = "asdfasdf"

    assert_difference 'Academic.count' do
      post academics_path, params: { academic: { name: name, email: email, password: password }}
    end

    assert_response :redirect
  end
end
