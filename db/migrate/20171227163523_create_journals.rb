class CreateJournals < ActiveRecord::Migration[5.1]
  def change
    create_table :journals do |t|
      t.string :title, null: false
      t.text :description
      t.decimal :impact_factor, null: false

      t.timestamps
    end
  end
end
