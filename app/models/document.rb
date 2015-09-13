class Document < ActiveRecord::Base
  belongs_to :folder

  validates :name, presence: true, length: {in: 3..50}
  # bug : field in form in red when present ..
  # validates :folder_id, presence: true
  validates :file_file_name, presence: true
  # useless to validates other file_* fields

  has_attached_file :file,
    :url => "/system/:class/:id_:basename.:extension",
    :path => ":rails_root/public/system/:class/:id_:basename.:extension"
  do_not_validate_attachment_file_type :file
end
