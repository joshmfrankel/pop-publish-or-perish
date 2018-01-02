class Academic < ApplicationRecord
  include Clearance::User

  validates :name, presence: true
end
