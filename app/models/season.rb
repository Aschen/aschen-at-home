class Season < ActiveRecord::Base
  belongs_to :serie
  has_many :episodes
  has_one :pending_download

end
