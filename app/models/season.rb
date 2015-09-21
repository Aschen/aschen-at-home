class Season < ActiveRecord::Base
  belongs_to :serie
  has_many :episodes
  has_one :pending_download

  validates :number, presence: true
  validates :episodes_count, presence: true
  validates :series_id, presence: true

  after_create :create_episodes

  before_destroy :delete_episodes


  def series
    Series.find(series_id)
  end

  private

  def create_episodes
    episodes_count.times do |n|
      Episode.create(number: n + 1, watched: false,
                     downloaded: false, season_id: id)
    end
  end

  def delete_episodes
    # Delete episodes
    episodes.destroy_all
    # Delete folder
    season_path = "#{Rails.root}/public/videos/#{series.name} Season #{number}".tr!(' ', '_')
    FileUtils.remove_dir(season_path, true)
  end
end
