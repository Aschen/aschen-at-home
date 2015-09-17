module ApplicationHelper

    def icon_yes_no(statement)
      if statement
        image_tag("icones/yes_icone.png", size: '30x30')
      else
        image_tag("icones/no_icone.png", size: '30x30')
      end
    end

end
