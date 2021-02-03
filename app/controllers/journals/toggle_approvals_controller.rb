module Journals
  class ToggleApprovalsController < ApplicationController
    before_action :require_login

    def update
      journal = Journal.find(params[:id])

      return head :unauthorized unless current_academic.admin_role? || current_academic.id == journal.approver_id

      journal.toggle_approval!(current_academic)

      flash[:notice] = journal.reload.approved? ? I18n.t("journals.toggle_approvals.update.approve") : I18n.t("journals.toggle_approvals.update.unapprove")

      head 200
    end
  end
end
