require 'spec_helper'

RSpec.describe SessionsController do

  let(:session_create) do
    user = create(:user, username: 'pknb', password: 'testtest', password_confirmation: 'testtest')
    post :create, session: { login: 'pknb', password: 'testtest' }
    expect(session[:user_id]).to eq(user.id)
  end

  it 'creates a session' do
    session_create
  end

  it 'destroys a session' do
    session_create
    get :destroy
    expect(session[:user_id]).to be_nil
  end
end
