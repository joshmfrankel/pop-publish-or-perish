# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Journal.create_or_find_by!([
  {
    title: "First Journal",
    impact_factor: 0.5
  },
  {
    title: "Second Journal",
    impact_factor: 0.5
  }
])

Academic.create_or_find_by!(name: "admin", role: :admin, email: "admin@example.com", password: "asdfasdf")
