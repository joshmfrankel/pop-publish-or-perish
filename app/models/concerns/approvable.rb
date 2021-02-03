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

  def toggle_approval!(user = nil)
    if approved?
      unapprove!
    else
      approve!(user)
    end
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

  def approved?
    self.approved_at.present? && self.approver_id.present?
  end

  def unapproved?
    !approved?
  end
end
