class Series < ActiveRecord::Base
  belongs_to :user
  has_many :seasons

#  serialize :key_words

  has_attached_file :jacket,
    url: "/system/:class/:id_:basename.:extension",
    path: ":rails_root/public/system/:class/:id_:basename.:extension",
    default_url: "/images/missing_jacket.png"
  do_not_validate_attachment_file_type :jacket

end
