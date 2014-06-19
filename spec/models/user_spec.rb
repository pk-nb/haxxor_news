require 'spec_helper'

RSpec.describe User do

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:username).case_insensitive }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should ensure_length_of(:username).is_at_least(4) }
  it { should ensure_length_of(:password).is_at_least(8) }
  it { should validate_confirmation_of(:password) }

  it { should allow_value('get_ready@for.com', 'the_best@fsd.dfs.co').for(:email) }
  it { should allow_value('h.+-1@test.com', 'money2$$.hi@many.sub.domains.com').for(:email) }
  it { should_not allow_value('!!@ha.com', 'one@two@three.com', 'blargh@email').for(:email) }

end
