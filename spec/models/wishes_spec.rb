require 'spec_helper.rb'

describe Wish do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:wish)).to be_valid
  end

  it 'is invalid without name' do
    expect(FactoryGirl.build(:wish, name: nil)).to_not be_valid
  end

  it 'is invalid with name < 5' do
    expect(FactoryGirl.build(:wish, name: 'toto')).to_not be_valid
  end

  it 'is invalid with name > 100' do
    expect(FactoryGirl.build(:wish, name: 'a' * 101)).to_not be_valid
  end

  it 'is invalid without user_id' do
    expect(FactoryGirl.build(:wish, user_id: nil)).to_not be_valid
  end

  it 'is invalid with incorrect link' do
    expect(FactoryGirl.build(:wish, link: 'http:/aschen.ovh')).to_not be_valid
  end
end
