require 'spec_helper'

RSpec.describe User do

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_uniqueness_of(:email) }
  it { should ensure_length_of(:username).is_at_least(4) }
  it { should ensure_length_of(:password).is_at_least(8) }
  it { should validate_confirmation_of(:password) }

end
