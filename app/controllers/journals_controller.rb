class JournalsController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def index
    journals = Journal.all
    search_term = params[:search_term]

    # Policy to exclude unapproved journals from guests/default role
    if !current_academic.admin_role? && !current_academic.approver_role?
      journals = journals.approved
    end

    if search_term.present?
      journals = journals.search_by_title(search_term)
    end

    @journals = journals
  end

  def new
    @journal = Journal.new
    @methodologies = Methodology.all
  end

  def show
    @journal = Journal.find(params[:id])
  end

  def edit
    @journal = Journal.find(params[:id])
    @methodologies = Methodology.all
  end

  def create
    journal = Journal.new(journal_params)

    if journal.save
      flash[:notice] = I18n.t("journal.create.success")

      redirect_to journals_path
    else
      flash[:error] = journal.errors.full_messages.to_sentence

      redirect_to new_journal_path
    end
  end

  def update
    journal = Journal.find(params[:id])

    if journal.update(journal_params)
      flash[:notice] = I18n.t("journal.update.success")

      redirect_to journal_path(journal)
    else
      flash[:error] = journal.errors.full_messages.to_sentence

      redirect_to edit_journal_path(journal)
    end
  end

  def destroy
    journal = Journal.find(params[:id])

    if journal.destroy
      flash[:notice] = I18n.t("journal.destroy.success")

      redirect_to journals_path
    else
      render json: { message: "Failure" }, status: :unprocessable_entity
    end
  end

  private

  def journal_params
    # params[:journal][:journal_methodologies_attributes][:methodology_id] = params[:journal][:journal_methodologies_attributes][:methodology_id].reject { |m| m.empty? }.map(&:to_i)
    params.require(:journal).permit(:title, :description, :impact_factor, journal_methodologies_attributes: { })
  end
end
