
FactoryGirl.define do
  factory :pending_download do |f|
    f.name 'Better.Call.Saul.S01E01.Xvid.avi'
    f.download_type 'season'
    f.season_id 1
    f.episode_id nil
    f.completed false
  end
end
