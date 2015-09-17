class Episode < ActiveRecord::Base
  belongs_to :season
  has_one :serie, :through => :seasons
  has_one :pending_download

  default_scope { order(number: :asc) }

end
