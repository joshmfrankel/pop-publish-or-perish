class Academic < ApplicationRecord
  # Contains validations for email and password
  include Clearance::User

  validates :name, presence: true
end
