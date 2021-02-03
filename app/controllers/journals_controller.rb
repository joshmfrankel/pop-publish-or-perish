class JournalsController < ApplicationController
  before_action :require_login, except: :index

  def index
    @journals = if search_term = params.dig(:journal, :search)
      Journal
        .where("title ~* :search_term", search_term: search_term.split(" ").join("|"))
    else
      Journal.all
    end.order(:title)
  end

  def new
    @journal = Journal.new
  end

  def create
    journal = Journal.new(journal_params)

    if journal.save
      flash[:notice] = I18n.t("journal.create.success")

      redirect_to journals_path
    else
      # TODO
    end
  end

  def update
    journal = Journal.find(params[:id])

    if journal.update(journal_params)
      render json: { message: "Success!" }, status: :ok
    else
      render json: { message: "Failure" }, status: :unprocessable_entity
    end
  end

  def destroy
    journal = Journal.find(params[:id])

    if journal.destroy
      render json: { message: "Success!" }, status: :ok
    else
      render json: { message: "Failure" }, status: :unprocessable_entity
    end
  end

  private

  def journal_params
    params.require(:journal).permit(:title, :description, :impact_factor)
  end
end
