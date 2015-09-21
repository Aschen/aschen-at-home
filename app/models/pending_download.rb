class PendingDownload < ActiveRecord::Base
  belongs_to :season
  belongs_to :episode

  after_create :set_episodes_downloaded

  private

  def set_episodes_downloaded
    if season_id
      episodes = Episode.where(season_id: season_id)
      episodes.each do |episode|
        episode.downloaded = true
        episode.save
      end
    elsif episode_id
      episode = Episode.find(episode_id)
      episode.downloaded = true
      episode.save
    end
  end
end
