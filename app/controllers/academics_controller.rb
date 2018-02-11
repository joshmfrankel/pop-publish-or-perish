class AcademicsController < ApplicationController
  def create
    Academic.create(academic_params)

    redirect_back fallback_location: root_path
  end

  private

  def academic_params
    params.require(:academic).permit(:name, :email, :password)
  end
end
