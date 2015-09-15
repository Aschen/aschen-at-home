namespace :watcher do

  desc "Watch for new video file, move them to public directory and update season/episode record"
  task new_video: :environment do
    Rails.logger.info "Start checking for new video file"

    # List all file and directory
    files = Dir.entries(Rails.configuration.x.directories.videos).select {|e| e != "." && e != ".."}

    files.each do |file|
      # TODO : filter by completed tag
      pending_download = PendingDownload.find_by(name: file)

      if pending_download.download_type == "season"
        Rails.logger.info "New season '#{file}' found !"
        season = Season.find(pending_download.season_id)
        series = Series.find(season.series_id)
        episodes = season.episodes
        season_dir = "#{series.name} Season #{season.number}".gsub!(' ', '_')
        public_dir = "#{Rails.root}/public/videos/#{season_dir}/"
        private_dir = "#{Rails.configuration.x.directories.videos}/#{file}/"

        # Select only video files
        videos = Dir.entries(private_dir).select{|e| !File.directory?(e) && is_video?(e)}

        # Create public dir for season if not exist
        FileUtils.mkdir_p(public_dir) unless File.directory?(public_dir)

        # Move video files and update records
        episodes.each do |episode|
          index = videos.index {|v| v.include?("E#{t411_number(episode.number)}")}
          break if !index
          File.rename("#{private_dir}/#{videos[index]}", "#{public_dir}/#{videos[index]}")
          episode.url = "/videos/#{season_dir}/#{videos[index]}"
          episode.downloaded = true
          episode.save
        end

        # Remove dir
        FileUtils.remove_dir(private_dir, true)

        pending_download.completed = true

        Rails.logger.info "Season successfully moved"
      elsif pending_download.download_type == "episode"
        Rails.logger.info "New episode'#{file}' found !"
        episode = Episode.find(pending_download.episode_id)
        season = Season.find(episode.season_id)
        series = Series.find(season.series_id)
        season_dir = "#{series.name} Season #{season.number}".gsub!(' ', '_')
        public_dir = "#{Rails.root}/public/videos/#{season_dir}/"
        episode_path = "#{Rails.configuration.x.directories.videos}/#{file}"

        # Create public dir for season if not exist
        FileUtils.mkdir_p(public_dir) unless File.directory?(public_dir)

        # Move video file and update record
        File.rename(episode_path, "#{public_dir}/#{file}")
        episode.url = "/videos/#{season_dir}/#{file}"
        episode.downloaded = true
        episode.save

        pending_download.completed = true

        Rails.logger.info "Episode successfully moved"
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

    def is_video?(filename)
      [".avi", ".mkv", ".mp4"].any? { |word| filename.include?(word) }
    end

end
