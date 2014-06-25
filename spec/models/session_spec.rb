require 'spec_helper'

RSpec.describe Session do
  it { should validate_presence_of(:login) }
  it { should validate_presence_of(:password) }

  describe "#valid?" do
    let!(:user) { create(:user) }

    it "returns false by default" do
      expect(subject).to_not be_valid
    end

    it "returns false when the credentials are invalid" do
      subject = described_class.new(login: user.username, password: 'foo')
      expect(subject).to_not be_valid
    end

    it "returns true when the email / password combination is valid" do
      subject = described_class.new(login: user.email, password: user.password)
      expect(subject).to be_valid
    end

    it "returns true when the username / password combination is valid" do
      subject = described_class.new(login: user.username, password: user.password)
      expect(subject).to be_valid
    end
  end
end
