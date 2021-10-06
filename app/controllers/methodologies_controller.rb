class MethodologiesController < ApplicationController
  before_action :set_methodology, only: [:show, :edit, :update, :destroy]

  # GET /methodologies
  # GET /methodologies.json
  def index
    redirect_to methodologies_path and return if !current_academic.admin_role?

    @methodologies = Methodology.all
  end

  # GET /methodologies/1
  # GET /methodologies/1.json
  def show
  end

  # GET /methodologies/new
  def new
    @methodology = Methodology.new
  end

  # GET /methodologies/1/edit
  def edit
  end

  # POST /methodologies
  # POST /methodologies.json
  def create
    @methodology = Methodology.new(methodology_params)

    respond_to do |format|
      if @methodology.save
        format.html { redirect_to @methodology, notice: 'Methodology was successfully created.' }
        format.json { render :show, status: :created, location: @methodology }
      else
        format.html { render :new }
        format.json { render json: @methodology.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /methodologies/1
  # PATCH/PUT /methodologies/1.json
  def update
    respond_to do |format|
      if @methodology.update(methodology_params)
        format.html { redirect_to @methodology, notice: 'Methodology was successfully updated.' }
        format.json { render :show, status: :ok, location: @methodology }
      else
        format.html { render :edit }
        format.json { render json: @methodology.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /methodologies/1
  # DELETE /methodologies/1.json
  def destroy
    @methodology.destroy
    respond_to do |format|
      format.html { redirect_to methodologies_url, notice: 'Methodology was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_methodology
      @methodology = Methodology.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def methodology_params
      params.require(:methodology).permit(:name)
    end
end
