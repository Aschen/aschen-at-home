class TorrentDownloaderController < ApplicationController

  # GET /login
  # POST /login
  def login
    if request.post?
      credentials = params.require(:t411)

      if t411_authenticate(credentials)
        redirect_to params.require(:destination), notice: 'Login successfull'
      else
        redirect_to action: :login, alert: 'Wrong credentials'
      end
    else
      @destination = params.require(:destination)
    end
  end

  # GET /download/season/:season_id
  def season
    @type = 'season'
    @id = params.require(:season_id)

    unless T411.authenticated?
      redirect_to controller: :torrent_downloader, action: :login,
                  destination: request.original_fullpath
      return
    end

    set_season_series(@id)
    set_and_sort_torrents('size')

    render :show
  end

  # GET /download/episode/:episode_id
  def episode
    @type = 'episode'
    @id = params.require(:episode_id)

    unless T411.authenticated?
      redirect_to controller: :torrent_downloader, action: :login,
                  destination: request.original_fullpath
      return
    end

    set_episode_season_series(@id)
    set_and_sort_torrents('seeders')

    render :show
  end

  # POST /download/go/:torrent_id
  def download
    torrent_id = params.require(:torrent_id)
    type = params.require(:type)
    id = params.require(:id)

    T411::Torrents.download(torrent_id, torrents_directory)
    torrent_info = get_torrent_info(torrent_id)
    PendingDownload.create(name: torrent_info['name'], download_type: type,
                           "#{type}_id" => id)

    # Get season id for redirection
    id = Episode.find(id).season_id if type == 'episode'
    redirect_to controller: 'seasons', action: 'show', id: id
  end

  private

  def get_torrent_info(torrent_id)
    stream = BEncode::Parser.new(File.open(torrent_file(torrent_id), 'rb'))
    stream.parse!['info']
  end

  def set_and_sort_torrents(sort_type)
    @torrents = search_for_torrents
    @torrents.sort_by! { |t| t[sort_type].to_i }.reverse! if @torrents
  end

  def set_episode_season_series(episode_id)
    @episode = Episode.find(episode_id)
    set_season_series(@episode.season_id)
  end

  def set_season_series(season_id)
    @season = Season.find(season_id)
    @series = @season.series
  end

  def search_query
    q = "#{@series.name} S#{t411_number(@season.number)}"
    q << "E#{t411_number(@episode.number)}" if @episode
    q
  end

  def search_for_torrents
    JSON(T411::Torrents.search(search_query, limit: 15))['torrents']
  end

  def torrent_file(torrent_id)
    "#{torrents_directory}#{torrent_id}.torrent"
  end

  def torrents_directory
    "#{Rails.configuration.x.directories.torrents}"
  end

  def t411_authenticate(t411)
    T411.authenticate(t411['username'], t411['password']) unless T411.authenticated?
    T411.authenticated?
  end

  def t411_number(number)
    if number < 10
      "0#{number}"
    else
      number
    end
  end

end
