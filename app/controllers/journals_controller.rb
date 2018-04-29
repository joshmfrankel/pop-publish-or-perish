class JournalsController < ApplicationController
  before_action :require_login

  def index
    @journals = Journal.all
  end

  def update
    journal = Journal.find(params[:id])

    if journal.update(journal_params)
      render json: { message: "Success!" }, status: :success
    else
      render json: { message: "Failure" }, status: :unprocessable_entity
    end
  end

  private

  def journal_params
    params.require(:journal).permit(:title, :description, :impact_factor)
  end
end
