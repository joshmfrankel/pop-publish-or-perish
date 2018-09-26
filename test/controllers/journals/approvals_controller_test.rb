require "test_helper"

class Journals::ApprovalsControllerTest < ActionDispatch::IntegrationTest

  test "GET #index" do
    get approvals_path(as: academics(:one))

    assert_response :success
  end

  test "PUT #update" do
    journal = journals(:one)
    put approval_path(journal, as: academics(:one))

    approved_journal = journal.reload

    assert_equal(academics(:one), approved_journal.approver)
    refute_nil(approved_journal.approved_at)
    assert_redirected_to root_path
  end
end
