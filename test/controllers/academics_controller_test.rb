require 'test_helper'

class AcademicsControllerTest < ActionDispatch::IntegrationTest

  test "POST #create succeeds with valid params" do
    name = "Josh"
    email = "admin@example.com"
    password = "asdfasdf"

    assert_nil cookies[:remember_token]

    assert_difference 'Academic.count' do
      post academics_path, params: { academic: { name: name, email: email, password: password }}
    end

    refute_nil cookies[:remember_token] # Successful signin
    assert_redirected_to root_path
  end

  test "POST #create fails with invalid params" do
    post academics_path, params: { academic: { name: nil, email: nil, password: nil }}


  end
end
