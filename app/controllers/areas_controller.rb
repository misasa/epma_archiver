class AreasController < ApplicationController
  before_action :set_area, only: [:show, :edit, :update, :destroy, :perform, :job]

  # GET /areas
  # GET /areas.json
  def index
#    @areas = Area.all
    params[:q] = Hash.new unless params[:q]
    params[:q][:s] = 'mtime desc'
    if params[:from] && params[:to]
      params[:q][:mtime_gteq] = params[:from]
      params[:q][:mtime_lteq] = params[:to]      
    end
    @q = Area.search(params[:q])
    @areas = @q.result(distinct: true)

  end

  # GET /areas/1
  # GET /areas/1.json
  def show
  end



  # GET /areas/new
  def new
    @area = Area.new
  end

  # GET /areas/1/edit
  def edit
  end

  # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(area_params)

    respond_to do |format|
      if @area.save
        format.html { redirect_to @area, notice: 'Area was successfully created.' }
        format.json { render :show, status: :created, location: @area }
      else
        format.html { render :new }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /areas/1/job
  def job
    path = @area.path
    @area.destroy
    
    @area = Area.create(:path => path)
    @area.prepare_maps
    AreaWorker.perform_async(@area.id)
    respond_to do |format|
      format.html { redirect_to @area, notice: 'Processing ...' }
      format.json { head :no_content }
    end
  end

  # PATCH/PUT /areas/1
  # PATCH/PUT /areas/1.json
  def update
    respond_to do |format|
      if @area.update(area_params)
        format.html { redirect_to @area, notice: 'Area was successfully updated.' }
        format.json { render :show, status: :ok, location: @area }
      else
        format.html { render :edit }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Area was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @area = Area.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def area_params
      params.require(:area).permit(:name, :path)
    end
end
