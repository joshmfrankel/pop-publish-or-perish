# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

truncate_table(table: "journals")
Journal.create([
  {
    title: "First Journal",
    description: "First Description",
    impact_factor: 0.5
  },
  {
    title: "Second Journal",
    description: "Second Description",
    impact_factor: 0.5
  }
])

def truncate_table(table:)
  ActiveRecord::Base.connection.execute("TRUNCATE #{table} RESTART IDENTITY CASCADE")
end
