class SeriesController < ApplicationController
  before_action :set_series, only: [:show, :edit, :update, :destroy]

  # GET /series
  def index
    @series = current_user.series
  end

  # GET /series/1
  def show
    @seasons = @series.seasons
  end

  # GET /series/new
  def new
    @series = Series.new
  end

  # GET /series/1/edit
  def edit
  end

  # POST /series
  def create
    @series = Series.new(series_params)

    if @series.save
      redirect_to series_index_path, notice: 'Series was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /series/1
  def update
    if @series.update(series_params)
      redirect_to :back, notice: 'Series was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /series/1
  def destroy
    @series.destroy
    redirect_to series_index_url, notice: 'Series was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_series
    @series = Series.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list
  def series_params
    params['series']['user_id'] = current_user.id
    params.require(:series).permit(:name, :key_words, :user_id, :jacket)
  end
end
