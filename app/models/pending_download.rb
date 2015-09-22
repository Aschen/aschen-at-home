class PendingDownload < ActiveRecord::Base
  belongs_to :season
  belongs_to :episode

  validates :name, presence: true
  validates :download_type, presence: true

  after_create :set_episodes_downloaded

  after_initialize :defaults

  scope :filename, -> (file) { where(completed: false, name: file) }

  def completed!(value = true)
    self.completed = value
    save
  end

  private

  def defaults
    self.completed = false
  end

  def set_episodes_downloaded
    if season_id
      episodes = Episode.where(season_id: season_id)
    elsif episode_id
      episodes = Episode.where(id: episode_id)
    end
    episodes.each(&:downloaded!)
  end
end
