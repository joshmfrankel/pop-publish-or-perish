require "test_helper"

class MethodologiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @methodology = methodologies(:one)
  end

  test "should get index" do
    get methodologies_url
    assert_response :success
  end

  test "should get new" do
    get new_methodology_url
    assert_response :success
  end

  test "should create methodology" do
    assert_difference('Methodology.count') do
      post methodologies_url, params: { methodology: {  } }
    end

    assert_redirected_to methodology_url(Methodology.last)
  end

  test "should show methodology" do
    get methodology_url(@methodology)
    assert_response :success
  end

  test "should get edit" do
    get edit_methodology_url(@methodology)
    assert_response :success
  end

  test "should update methodology" do
    patch methodology_url(@methodology), params: { methodology: {  } }
    assert_redirected_to methodology_url(@methodology)
  end

  test "should destroy methodology" do
    assert_difference('Methodology.count', -1) do
      delete methodology_url(@methodology)
    end

    assert_redirected_to methodologies_url
  end
end
