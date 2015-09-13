class Episode < ActiveRecord::Base
  belongs_to :season
  has_one :serie, :through => :seasons


end
