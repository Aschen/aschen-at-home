module DocumentsHelper

  def content_type_icone(file)
    content_type = file.content_type
    icones = {"application/pdf" => "icones/pdf_icone.png",
              "application/msword" => "icones/doc_icone.png",
              "image/jpeg" => "icones/jpg_icone.gif",
              "image/png" => "icones/jpg_icone.gif",
              "image/bmp" => "icones/jpg_icone.gif",
              "image/gif" => "icones/jpg_icone.gif"}

    if icones.has_key?(content_type)
      icones[content_type]
    else
      "icones/unknown_icone.png"
    end
  end

end
