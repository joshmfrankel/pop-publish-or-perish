class DropDescriptionFromJournals < ActiveRecord::Migration[5.1]
  def change
    remove_column :journals, :description
  end
end
