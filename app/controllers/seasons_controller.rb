class SeasonsController < ApplicationController
  before_action :set_season, only: [:show, :edit, :update, :destroy]

  # GET /seasons
  # GET /seasons.json
  def index
    @seasons = Season.all
  end

  # GET /seasons/1
  # GET /seasons/1.json
  def show
    @series = Series.find(@season.series_id)
    @episodes = @season.episodes
  end

  # GET /seasons/new
  def new
    @season = Season.new
    @season.series_id = params["series_id"]
  end

  # GET /seasons/1/edit
  def edit
    @series = Series.find(@season.series_id)
  end

  # POST /seasons
  # POST /seasons.json
  def create
    @season = Season.new(season_params)

    respond_to do |format|
      if @season.save
        @series = Series.find(@season.series_id)
        # Create episodes
        @season.episodes_count.times {|n| Episode.create(number: n + 1, watched: false, downloaded: false, season_id: @season.id)}
        format.html { redirect_to @season, notice: 'Season was successfully created.' }
        format.json { render :show, status: :created, location: @season }
      else
        format.html { render :new }
        format.json { render json: @season.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seasons/1
  # PATCH/PUT /seasons/1.json
  def update
    @series = Series.find(@season.series_id)

    respond_to do |format|
      if @season.update(season_params)
        format.html { redirect_to :back, notice: 'Season was successfully updated.' }
        format.json { render :show, status: :ok, location: @season }
      else
        format.html { render :edit }
        format.json { render json: @season.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seasons/1
  # DELETE /seasons/1.json
  def destroy
    @series = Series.find(@season.series_id)
    season_path = "#{Rails.root}/public/videos/#{@series.name} Season #{@season.number}".gsub!(' ', '_')
    FileUtils.remove_dir(season_path, true)

    # TODO : optimize request
    @season.episodes.each {|episode| episode.delete}
    @season.destroy

    respond_to do |format|
      format.html { redirect_to @series, notice: 'Season was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_season
      @season = Season.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def season_params
      params.require(:season).permit(:number, :episodes_count, :auto_download, :series_id)
    end
end
