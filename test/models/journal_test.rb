require 'test_helper'

class JournalTest < ActiveSupport::TestCase

  test "#approve!" do
    academic = academics(:one)
    journal = Journal.new(title: "test", description: "test", impact_factor: 0.5)

    journal.approve!(academic)

    assert_equal(journal.approver, academic)
    assert_not_nil(journal.approved_at)
  end

  test "#unapprove!" do
    academic = academics(:one)
    journal = Journal.new(title: "test", description: "test", impact_factor: 0.5, approved_at: DateTime.now, approver: academic)

    journal.unapprove!

    assert_nil(journal.approver)
    assert_nil(journal.approved_at)
  end
end
