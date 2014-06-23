require 'spec_helper'

RSpec.describe Session do
  it { should validate_presence_of(:login) }
  it { should validate_presence_of(:password) }

  describe "#valid?" do
    it "is false by default" do
      expect(subject).to_not be_valid
    end

    it "is false when the credentials are invalid" do
      FactoryGirl.create(:user, username: 'nathanael', password: 'password', password_confirmation: 'password')
      subject = described_class.new(login: 'nathanael', password: 'foo')
      expect(subject).to_not be_valid
    end

    it "is true when the email / password combination is valid" do
      FactoryGirl.create(:user, email: 'nathanael@viget.com', password: 'password', password_confirmation: 'password')
      subject = described_class.new(login: 'nathanael@viget.com', password: 'password')
      expect(subject).to be_valid
    end

    it "is true when the username / password combination is valid" do
      FactoryGirl.create(:user, username: 'ron_swanson', password: 'password', password_confirmation: 'password')
      subject = described_class.new(login: 'ron_swanson', password: 'password')
      expect(subject).to be_valid
    end
  end
end
