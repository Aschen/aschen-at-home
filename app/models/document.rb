class Document < ActiveRecord::Base
  belongs_to :folder
  has_attached_file :file,
    :url => "/system/:class/:id_:basename.:extension",
    :path => ":rails_root/public/system/:class/:id_:basename.:extension"
  do_not_validate_attachment_file_type :file
end
