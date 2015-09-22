require 'rails_helper'

RSpec.feature "Signins", type: :feature do
  before :each do
    email = 'adrien@aschen.ovh'
    password = 'password1234'
    User.create(:email => email, :password => password, :password_confirmation => password)
  end

  it "signs me in" do
    visit '/users/sign_in'
    fill_in 'user_email', :with => 'adrien@aschen.ovh'
    fill_in 'user_password', :with => 'password1234'
    click_button 'Log in'
    expect(page).to have_content 'successfully'
  end
end
