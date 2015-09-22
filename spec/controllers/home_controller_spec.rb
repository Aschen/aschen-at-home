require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  it "blocks unauthenticated access" do
    sign_in nil

    get :home

    expect(response).to redirect_to(new_user_session_path)
  end

  it "allows authenticated access" do
    sign_in

    get :home

    expect(response).to be_success
  end

end
