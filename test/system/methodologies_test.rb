require "application_system_test_case"

class MethodologiesTest < ApplicationSystemTestCase
  setup do
    @methodology = methodologies(:one)
  end

  test "visiting the index" do
    visit methodologies_url
    assert_selector "h1", text: "Methodologies"
  end

  test "creating a Methodology" do
    visit methodologies_url
    click_on "New Methodology"

    click_on "Create Methodology"

    assert_text "Methodology was successfully created"
    click_on "Back"
  end

  test "updating a Methodology" do
    visit methodologies_url
    click_on "Edit", match: :first

    click_on "Update Methodology"

    assert_text "Methodology was successfully updated"
    click_on "Back"
  end

  test "destroying a Methodology" do
    visit methodologies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Methodology was successfully destroyed"
  end
end
