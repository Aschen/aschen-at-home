module SeasonsHelper

  def original_file_state_image(episode)
    file_state_image(episode, episode.original_file)
  end

  def mp4_file_state_image(episode)
    file_state_image(episode, episode.mp4_file)
  end

  private

  def file_state_image(episode, file)
    if file
      image_tag("icones/download_icone.png", size: '30x30')
    elsif episode.downloaded
      image_tag("icones/sablier_icone.png", size: '30x30')
    else
      image_tag("icones/no_icone.png", size: '30x30')
    end
  end
end
