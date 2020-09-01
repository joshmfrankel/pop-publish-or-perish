module Journals
  class ApprovalsController < ApplicationController
    before_action :require_login

    def index
      head :unauthorized unless current_user.admin_role?

      @journals = Journal.unapproved
    end

    def update
      head :unauthorized unless current_user.admin_role?

      journal = Journal.find(params[:id])
      journal.approve!(current_user)

      flash[:notice] = I18n.t("journals.approvals.update.success")

      redirect_back fallback_location: root_path
    end
  end
end
