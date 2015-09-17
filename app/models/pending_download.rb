class PendingDownload < ActiveRecord::Base
  belongs_to :season
  belongs_to :episode
  
end
