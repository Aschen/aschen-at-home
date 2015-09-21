class SeasonsController < ApplicationController
  before_action :set_season, only: [:show, :edit, :update, :destroy]
  before_action :set_series, only: [:show, :edit, :update, :destroy]

  # GET /seasons
  def index
    @seasons = Season.all
  end

  # GET /seasons/1
  def show
    @episodes = @season.episodes
  end

  # GET /seasons/new
  def new
    @season = Season.new
    @season.series_id = params['series_id']
  end

  # GET /seasons/1/edit
  def edit
  end

  # POST /seasons
  def create
    @season = Season.new(season_params)

    if @season.save
      @series = @season.series
      redirect_to @season, notice: 'Season was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /seasons/1
  def update
    if @season.update(season_params)
      redirect_to :back, notice: 'Season was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /seasons/1
  def destroy
    @season.destroy
    redirect_to @series, notice: 'Season was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_season
    @season = Season.find(params[:id])
  end

  def set_series
    @series = @season.series
  end

  # Never trust parameters from the scary internet, only allow the white list
  def season_params
    params.require(:season).permit(:number, :episodes_count, :auto_download,
                                   :series_id)
  end
end
