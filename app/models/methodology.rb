class Methodology < ApplicationRecord
  has_many :journal_methodologies
  has_many :journals, through: :journal_methodologies
end
