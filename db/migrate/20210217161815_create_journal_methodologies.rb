class CreateJournalMethodologies < ActiveRecord::Migration[6.1]
  def change
    create_table :journal_methodologies do |t|
      t.references :journal, null: false, foreign_key: true
      t.references :methodology, null: false, foreign_key: true

      t.timestamps
    end
  end
end
