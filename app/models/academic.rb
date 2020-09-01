class Academic < ApplicationRecord
  # Contains validations for email and password
  include Clearance::User

  enum role: {
    default: 0,
    approver: 1,
    admin: 2
  }, _suffix: true

  validates :name, presence: true
end
