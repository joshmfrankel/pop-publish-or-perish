class AcademicsController < ApplicationController
  def create
    Academic.create(academic_params[:academic])

    redirect_back fallback_location: root_path
  end

  private

  def academic_params
    params.permit(academic: [:name, :email, :password])
  end
end
