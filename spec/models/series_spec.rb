require 'spec_helper.rb'

describe Series do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:series)).to be_valid
  end

  it 'is invalid without name' do
    expect(FactoryGirl.build(:series, name: nil)).to_not be_valid
  end

  it 'is invalid without key words' do
    expect(FactoryGirl.build(:series, key_words: nil)).to_not be_valid
  end

  it 'is invalid without user id' do
    expect(FactoryGirl.build(:series, user_id: nil)).to_not be_valid
  end

end
