class AcademicsController < Clearance::UsersController

  def new
    @academic = Academic.new
  end

  def create
    academic = Academic.new(academic_params)

    if academic.save
      sign_in(academic)

      flash[:notice] = I18n.t(".signin")

      redirect_back fallback_location: root_path
    end
  end

  private

  def academic_params
    params.require(:academic).permit(:name, :email, :password)
  end
end
