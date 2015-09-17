namespace :watcher do

  desc "Watch for new video file, move them to public directory and update season/episode record"
  task videos: :environment do
    Rails.logger.info 'Start checking for new video file'

    # List all file and directory
    files = Dir.entries(Rails.configuration.x.directories.videos).select { |e| e != '.' && e != '..'}

    files.each do |file|
      # TODO : filter by completed tag
      pending_download = PendingDownload.find_by(name: file)
      next unless pending_download

      if pending_download.download_type == 'season'
        Rails.logger.info "New season '#{file}' found !"
        season = Season.find(pending_download.season_id)
        series = Series.find(season.series_id)
        episodes = season.episodes
        season_dir = "#{series.name} Season #{season.number}".tr!(' ', '_')
        public_dir = "#{Rails.root}/public/videos/#{season_dir}/"
        private_dir = "#{Rails.configuration.x.directories.videos}/#{file}/"

        # Select only video files
        videos = Dir.entries(private_dir).select { |e| !File.directory?(e) && video?(e) }

        # Create public dir for season if not exist
        FileUtils.mkdir_p(public_dir) unless File.directory?(public_dir)

        # Create a link and update record
        episodes.each do |episode|
          index = videos.index { |v| v.include?("E#{t411_number(episode.number)}") }
          next unless index
          File.symlink("#{private_dir}/#{videos[index]}", "#{public_dir}/#{videos[index]}")
          episode.original_file = "/videos/#{season_dir}/#{videos[index]}"
          episode.save
        end

        pending_download.completed = true
        pending_download.save

        Rails.logger.info 'Season successfully moved'

      elsif pending_download.download_type == 'episode'
        Rails.logger.info "New episode'#{file}' found !"
        episode = Episode.find(pending_download.episode_id)
        season = Season.find(episode.season_id)
        series = Series.find(season.series_id)
        season_dir = "#{series.name} Season #{season.number}".tr!(' ', '_')
        public_dir = "#{Rails.root}/public/videos/#{season_dir}/"
        private_dir = "#{Rails.configuration.x.directories.videos}/"

        # Find video file
        if File.directory?("#{Rails.configuration.x.directories.videos}/#{file}")
          private_dir << "#{file}/"
          video_file = Dir.entries(private_dir).select{ |e| !File.directory?(e) && video?(e) }.first
        else
          video_file = file
        end

        # Create public dir for season if not exist
        FileUtils.mkdir_p(public_dir) unless File.directory?(public_dir)

        # Create a link and update record
        File.symlink("#{private_dir}/#{video_file}", "#{public_dir}/#{video_file}")
        episode.original_file = "/videos/#{season_dir}/#{video_file}"
        episode.save

        pending_download.completed = true
        pending_download.save

        Rails.logger.info 'Episode successfully moved'
      end
    end

  end

  private

  def t411_number(number)
    if number < 10
      "0#{number}"
    else
      number
    end
  end

  def video?(filename)
    ['.avi', '.mkv', '.mp4'].any? { |word| filename.include?(word) }
  end

end
