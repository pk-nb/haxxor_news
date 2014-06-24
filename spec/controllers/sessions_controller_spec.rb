require 'spec_helper'

RSpec.describe SessionsController do
  it 'creates a session' do
    expect(session[:user_id]).to be_nil
    user = FactoryGirl.create(:user, username: 'pknb', password: 'testtest', password_confirmation: 'testtest')
    post :create, session: { login: 'pknb', password: 'testtest' }
    expect(session[:user_id]).to eq(user.id)
  end

  it 'destroys a session' do
    expect(session[:user_id]).to be_nil
    user = FactoryGirl.create(:user, username: 'pknb', password: 'testtest', password_confirmation: 'testtest')
    post :create, session: { login: 'pknb', password: 'testtest' }
    expect(session[:user_id]).to eq(user.id)
    get :destroy
    expect(session[:user_id]).to be_nil
  end
end
