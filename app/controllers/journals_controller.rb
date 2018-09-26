class JournalsController < ApplicationController
  before_action :require_login

  def index
    @journals = Journal.approved
  end

  def new
    @journal = Journal.new
  end

  def create
    journal = Journal.new(journal_params)

    if journal.save
      flash[:notice] = I18n.t("journal.create.success")

      redirect_back fallback_location: root_path
    else
      # TODO
    end
  end

  def update
    journal = Journal.find(params[:id])

    if journal.update!(journal_params)
      render json: { message: "Success!" }, status: :success
    else
      render json: { message: "Failure" }, status: :unprocessable_entity
    end
  end

  def destroy
    journal = Journal.find(params[:id])

    if journal.destroy
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
