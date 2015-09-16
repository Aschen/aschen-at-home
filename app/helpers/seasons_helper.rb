module SeasonsHelper

  def download_state_image(episode)
    if episode.url
      image_tag("icones/download_icone.png", size: '30x30')
    elsif episode.downloaded
      image_tag("icones/sablier_icone.png", size: '30x30')
    else
      image_tag("icones/no_icone.png", size: '30x30')
    end
  end

end
