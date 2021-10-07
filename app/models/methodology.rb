class Methodology < ApplicationRecord
  has_many :journal_methodologies, dependent: :destroy
  has_many :journals, through: :journal_methodologies
end
