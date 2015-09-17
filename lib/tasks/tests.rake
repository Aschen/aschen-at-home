namespace :tests do
  desc 'Enconding test, obviously'
  task encoding: :environment do
    avi_path = "#{Rails.root}/private/videos/small_3.avi"
    avi_video = FFMPEG::Movie.new(avi_path)
    options = { video_codec: 'libx264', audio_codec: 'libfdk_aac',
                custom: '-movflags +faststart', threads: 3 }
    mp4_video = avi_video.transcode(avi_path.gsub('avi', 'mp4'), options) { |p| puts p }

  end

end
