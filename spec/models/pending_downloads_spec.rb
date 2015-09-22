require 'spec_helper.rb'

describe PendingDownload do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:pending_download)).to be_valid
  end

  it 'is invalid without name' do
    expect(FactoryGirl.build(:pending_download, name: nil)).to_not be_valid
  end

  it 'is invalid without download_type' do
    expect(FactoryGirl.build(:pending_download, download_type: nil)).to_not be_valid
  end
end
