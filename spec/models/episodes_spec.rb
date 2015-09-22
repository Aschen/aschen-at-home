require 'spec_helper.rb'

describe Episode do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:episode)).to be_valid
  end

  it 'is invalid without number' do
    expect(FactoryGirl.build(:episode, number: nil)).to_not be_valid
  end

  it 'is invalid without season id' do
    expect(FactoryGirl.build(:episode, season_id: nil)).to_not be_valid
  end
  
end
