class AddClearanceToAcademics < ActiveRecord::Migration[5.1]
  def change
    # In order to add not null constraints to a table with existing data
    # you need to add them in a two-step process
    #
    # Step 1: Add columns without null constraint
    change_table :academics do |t|
      t.string :email
      t.string :encrypted_password, limit: 128
      t.string :confirmation_token, limit: 128
      t.string :remember_token, limit: 128
    end

    # Step 2: Add null constraint
    change_column_null :academics, :email, false
    change_column_null :academics, :encrypted_password, false
    change_column_null :academics, :remember_token, false

    add_index :academics, :email
    add_index :academics, :remember_token
  end
end
