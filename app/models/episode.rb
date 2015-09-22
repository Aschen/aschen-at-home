class Episode < ActiveRecord::Base
  belongs_to :season
  has_one :serie, through: :seasons
  has_one :pending_download

  validates :number, presence: true
  validates :season_id, presence: true

  default_scope { order(number: :asc) }


  # Delete old files
  after_update :delete_files, if: :original_file_changed?

  # Start conversion when file is added
  after_update :convert_to_mp4, if: :original_file_changed?

  # Delete physical files
  before_destroy :delete_files

  # Increment season episodes_count
  after_create :increment_count

  # Decrement season episodes_count
  before_destroy :decrement_count

  def original_file!(file)
    self.original_file = file
    save
  end

  def mp4_file!(file)
    self.mp4_file = file
    save
  end

  def downloaded!(value = true)
    self.downloaded = value
    save
  end

  private

  def increment_count
    season.episodes_count!(1)
  end

  def decrement_count
    season.episodes_count!(-1)
  end

  def convert_to_mp4
    return unless original_file
    avi_path = "#{Rails.root}/public/#{original_file}"
    Rails.logger.info("Start converting #{avi_path} to mp4")
    avi_video = FFMPEG::Movie.new(avi_path)
    options = { video_codec: 'libx264', audio_codec: 'libfdk_aac',
                custom: '-movflags +faststart', threads: 3 }
    avi_video.transcode(avi_path.gsub('avi', 'mp4'), options)
    mp4_file! original_file.gsub('avi', 'mp4')
    Rails.logger.info('Conversion success')
  end
  handle_asynchronously :convert_to_mp4

  def delete_files
    if original_file
      path = "#{Rails.root}/public/#{original_file}"
      File.delete(path) if File.exist?(path)
    end

    if mp4_file
      path = "#{Rails.root}/public/#{mp4_file}"
      File.delete(path) if File.exist?(path)
    end
  end

end
