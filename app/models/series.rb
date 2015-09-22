class Series < ActiveRecord::Base
  belongs_to :user
  has_many :seasons

  validates :name, presence: true
  validates :key_words, presence: true
  validates :user_id, presence: true
  
  before_destroy :delete_season

  # serialize :key_words

  has_attached_file :jacket,
                    url: '/system/:class/:id/:basename.:extension',
                    path: ':rails_root/public/system/:class/:id/:basename.:extension',
                    default_url: '/images/missing_jacket.png'
  do_not_validate_attachment_file_type :jacket

  private

  def delete_season
    seasons.destroy_all
  end
end
