require 'spec_helper.rb'

describe Season do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:season)).to be_valid
  end

  it 'is invalid without number' do
    expect(FactoryGirl.build(:season, number: nil)).to_not be_valid
  end

  it 'is invalid without episodes count' do
    expect(FactoryGirl.build(:season, episodes_count: nil)).to_not be_valid
  end

  it 'is invalid without series id' do
    expect(FactoryGirl.build(:season, series_id: nil)).to_not be_valid
  end

end
