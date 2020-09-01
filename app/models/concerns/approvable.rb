module Approvable
  extend ActiveSupport::Concern

  class_methods do
    def has_unapproved?
      unapproved.exists?
    end
  end

  included do
    scope :approved, -> { where.not(approved_at: nil, approver: nil) }
    scope :unapproved, -> { where(approved_at: nil, approver: nil) }
  end

  def approve!(user)
    self.approved_at = DateTime.now
    self.approver = user
    save!
  end

  def unapprove!
    self.approved_at = nil
    self.approver = nil
    save!
  end
end
