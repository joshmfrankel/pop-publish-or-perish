class Journal < ApplicationRecord
  include Approvable

  belongs_to :approver, class_name: "Academic", required: false
  has_many :journal_methodologies
  has_many :methodologies, through: :journal_methodologies

  validates :impact_factor, presence: true

  accepts_nested_attributes_for :journal_methodologies

  scope :search_by_title, ->(search_term) { where("title ~* :search_term", search_term: search_term.split(" ").join("|")) }
end
