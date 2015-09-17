class Episode < ActiveRecord::Base
  belongs_to :season
  has_one :serie, through: :seasons
  has_one :pending_download

  default_scope { order(number: :asc) }

  # Start conversion when file is added
  after_update :convert_to_mp4, if: :original_file_changed?

  private

  def convert_to_mp4
    Rails.logger.info("Start converting #{original_file} to mp4")
    avi_path = "#{Rails.root}/#{original_file}"
    avi_video = FFMPEG::Movie.new(avi_path)
    options = { video_codec: 'libx264', audio_codec: 'libfdk_aac',
                custom: '-movflags +faststart', threads: 3 }
    avi_video.transcode(avi_path.gsub('avi', 'mp4'), options)
    self.mp4_file = original_file.gsub('avi', 'mp4')
    save
    Rails.logger.info('Conversion success')
  end
  handle_asynchronously :convert_to_mp4

end
