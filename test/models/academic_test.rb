require "test_helper"

class AcademicTest < ActiveSupport::TestCase
  def setup
    @academic = Academic.new(name: "Josh", role: 0)
  end

  test "is invalid without name" do
    @academic.name = nil

    refute @academic.valid?
  end

  test "is invalid without role" do
    @academic.role = nil

    assert_raises ActiveRecord::NotNullViolation do
      @academic.save!
    end
  end
end
