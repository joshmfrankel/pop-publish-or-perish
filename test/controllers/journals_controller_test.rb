require 'test_helper'

class JournalsControllerTest < ActionDispatch::IntegrationTest

  test "#index" do
    get journals_path(as: academics(:one))

    assert_response :success
  end

  test "#update" do
    journal = journals(:one)

    patch journal_path(journal, as: academics(:one)), params: {
      journal: {
        title: "Test update"
      }
    }

    assert_response :success

    journal.reload

    assert_equal "Test update", journal.title
  end
end
