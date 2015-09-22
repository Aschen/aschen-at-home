require 'spec_helper.rb'

describe Document do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:document)).to be_valid
  end

  it 'is invalid without name' do
    expect(FactoryGirl.build(:document, name: nil)).to_not be_valid
  end

  it 'is invalid with name < 3' do
    expect(FactoryGirl.build(:document, name: 'to')).to_not be_valid
  end

  it 'is invalid with name > 50' do
    expect(FactoryGirl.build(:document, name: 'a' * 51)).to_not be_valid
  end

  it 'is invalid without folder_id' do
    expect(FactoryGirl.build(:document, folder_id: nil)).to_not be_valid
  end

  it 'is invalid without file_file_name' do
    expect(FactoryGirl.build(:document, file_file_name: nil)).to_not be_valid
  end
end
