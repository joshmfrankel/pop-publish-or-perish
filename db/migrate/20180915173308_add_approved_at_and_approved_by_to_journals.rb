class AddApprovedAtAndApprovedByToJournals < ActiveRecord::Migration[5.1]
  def change
    add_column :journals, :approved_at, :datetime
    add_reference :journals, :approver, references: :academics, index: true
    add_foreign_key :journals, :academics, column: :approver_id
  end
end
