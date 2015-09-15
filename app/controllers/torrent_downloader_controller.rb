class TorrentDownloaderController < ApplicationController

  # GET/POST /login
  def login
    if request.post?
      credentials = params.require(:t411)

      if t411_authenticate(credentials)
        redirect_to params.require(:destination), notice: "Login successfull"
      else
        redirect_to action: :login, alert: "Wrong credentials"
      end
    else
      @destination = params.require(:destination)
    end
  end

  # GET /download/season/:season_id
  def season
    season_id = params.require(:season_id)
    @type = "season"
    @id = season_id

    if !T411.authenticated?
      redirect_to controller: :torrent_downloader, action: :login, destination: request.original_fullpath
      return
    end

    @season = Season.find(season_id)
    @series = Series.find(@season.series_id)

    query = "#{@series.name} S#{t411_number(@season.number)}"

    @torrents = JSON(T411::Torrents.search(query, limit: 10))["torrents"]
    if @torrents
      # Sort by size
      @torrents.sort_by!{|t| t["size"].to_i}.reverse!
    end

    render :show
  end

  # GET /download/episode/:episode_id
  def episode
    episode_id = params.require(:episode_id)
    @type = "episode"
    @id = episode_id

    if !T411.authenticated?
      redirect_to controller: :torrent_downloader, action: :login, destination: request.original_fullpath
      return
    end

    @episode = Episode.find(episode_id)
    @season = Season.find(@episode.season_id)
    @series = Series.find(@season.series_id)

    query = "#{@series.name} S#{t411_number(@season.number)}E#{t411_number(@episode.number)}"

    @torrents = JSON(T411::Torrents.search(query, limit: 10))["torrents"]
    if @torrents
      # Sort by seeders
      @torrents.sort_by!{|t| t["seeders"].to_i}.reverse!
    end

    render :show
  end

  # POST /download/go/:torrent_id
  def download
    torrent_id = params.require(:torrent_id)
    type = params.require(:type)
    id = params.require(:id)

    T411::Torrents.download(torrent_id, torrents_directory)
    # TODO : check file presence
    torrent_info = TorrentFile.open(torrent_file(torrent_id)).to_h["info"]

    if type == "season"
      PendingDownload.create({name: torrent_info["name"], download_type: type, season_id: id})
    elsif type == "episode"
      PendingDownload.create({name: torrent_info["name"], download_type: type, episode_id: id})
    end
    # TODO : check record creation

    redirect_to :back
  end


  private

    def torrent_file(torrent_id)
      "#{torrents_directory}#{torrent_id}.torrent"
    end

    def torrents_directory
      "#{Rails.configuration.x.directories.torrents}"
    end

    def t411_authenticate(t411)
      T411.authenticate(t411["username"], t411["password"]) unless T411.authenticated?
      return T411.authenticated?
    end

    def t411_number(number)
      if number < 10
        "0#{number}"
      else
        number
      end
    end

end
