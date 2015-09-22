require 'spec_helper.rb'

describe Folder do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:folder)).to be_valid
  end

  it 'is invalid without name' do
    expect(FactoryGirl.build(:folder, name: nil)).to_not be_valid
  end

  it 'is invalid with name < 3' do
    expect(FactoryGirl.build(:folder, name: 'to')).to_not be_valid
  end

  it 'is invalid with name > 50' do
    expect(FactoryGirl.build(:folder, name: 'a' * 51)).to_not be_valid
  end

  it 'is invalid without user_id' do
    expect(FactoryGirl.build(:folder, user_id: nil)).to_not be_valid
  end
end
