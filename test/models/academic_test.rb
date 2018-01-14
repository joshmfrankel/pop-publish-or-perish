require "test_helper"

class AcademicTest < ActiveSupport::TestCase
  def setup
    @academic = Academic.new(
      name: "Josh",
      role: 0,
      email: "josh@example.com",
      password: "asdfasdf"
    )
  end

  test "is invalid without name" do
    @academic.name = nil

    refute @academic.valid?
  end

  test "is invalid without email" do
    @academic.email = nil

    refute @academic.valid?
  end

  test "is invalid without password" do
    @academic.password = nil

    refute @academic.valid?
  end

  test "raises NotNullViolation without role" do
    @academic.role = nil

    assert_raises ActiveRecord::NotNullViolation do
      @academic.save!
    end
  end
end
