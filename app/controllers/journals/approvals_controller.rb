module Journals
  class ApprovalsController < ApplicationController
    before_action :require_login

    def index
      @journals = Journal.unapproved
    end

    def update
      journal = Journal.find(params[:id])
      journal.approve!(current_user)

      flash[:notice] = I18n.t("journals.approvals.update.success")

      redirect_back fallback_location: root_path
    end
  end
end
