class CreateAcademics < ActiveRecord::Migration[5.1]
  def change
    create_table :academics do |t|
      t.string :name, null: false
      t.string :title
      t.integer :role, null: false, default: 0

      t.timestamps
    end
  end
end
