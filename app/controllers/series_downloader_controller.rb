class SeriesDownloaderController < ApplicationController

  def home
    season_id = params.require(:season_id)
    @season = Season.find(season_id)
    @series = Series.find(@season.series_id)
    @episodes = @season.episodes
  end

end
