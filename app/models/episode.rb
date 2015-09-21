class Episode < ActiveRecord::Base
  belongs_to :season
  has_one :serie, through: :seasons
  has_one :pending_download

  validates :number, presence: true
  validates :season_id, presence: true

  default_scope { order(number: :asc) }

  # Start conversion when file is added
  after_update :convert_to_mp4, if: :original_file_changed?

  # Delete physical files
  before_destroy :delete_files

  private

  def convert_to_mp4
    avi_path = "#{Rails.root}/public/#{original_file}"
    Rails.logger.info("Start converting #{avi_path} to mp4")
    avi_video = FFMPEG::Movie.new(avi_path)
    options = { video_codec: 'libx264', audio_codec: 'libfdk_aac',
                custom: '-movflags +faststart', threads: 3 }
    avi_video.transcode(avi_path.gsub('avi', 'mp4'), options)
    self.mp4_file = original_file.gsub('avi', 'mp4')
    save
    Rails.logger.info('Conversion success')
  end
  handle_asynchronously :convert_to_mp4

  def delete_files
    if original_file
      path = "#{Rails.root}/public/#{@episode.original_file}"
      File.delete(path) if File.exist?(path)
    end

    if mp4_file
      path = "#{Rails.root}/public/#{@episode.mp4_file}"
      File.delete(path) if File.exist?(path)
    end
  end

end
