namespace :watcher do

  desc 'Watch for new video file, move them to public directory and update season/episode record'
  task videos: :environment do
    Rails.logger.info 'Start checking for new video file'

    # List all file and directory
    files = Dir.entries(Rails.configuration.x.directories.videos).select { |e| e != '.' && e != '..'}

    files.each do |file|
      pending_download = PendingDownload.filename(file).first
      next unless pending_download

      init_episodes_season_series(pending_download)
      init_work_directories(file)
      
      Rails.logger.info "New #{pending_download.download_type} '#{file}' found."

      # Select all video in directory else @private_dir is the file
      if File.directory?(@private_dir)
        video_files = Dir.entries(@private_dir).select { |e| !File.directory?(e) && video?(e) }
      else
        video_files = [file]
      end

      # Create a link and update record
      @episodes.each do |episode|
        index = video_files.index { |v| v.include?("E#{t411_number(episode.number)}") }
        next unless index
        next if File.exist?("#{@public_dir}/#{video_files[index]}")

        File.symlink("#{@private_dir}/#{video_files[index]}",
                     "#{@public_dir}/#{video_files[index]}")
        episode.original_file! "/videos/#{@season_dir}/#{video_files[index]}"
      end

      pending_download.completed!

      Rails.logger.info "#{pending_download.download_type} successfully moved."
    end
  end

  private

  def init_work_directories(file)
    @season_dir = "#{@series.name} Season #{@season.number}".tr!(' ', '_')
    @public_dir = "#{Rails.root}/public/videos/#{@season_dir}"
    @private_dir = "#{Rails.configuration.x.directories.videos}"

    # Single file or directory ?
    @private_dir << "/#{file}" if File.directory?("#{@private_dir}/#{file}")
    # Create public dir for season if not exist
    FileUtils.mkdir_p(@public_dir) unless File.directory?(@public_dir)
  end

  def init_episodes_season_series(pending_download)
    if pending_download.episode_id
      @episodes = Episode.where(id: pending_download.episode_id)
    elsif pending_download.season_id
      @episodes = Episode.where(season_id: pending_download.season_id)
    end

    @season = @episodes.first.season
    @series = @season.series
  end

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
