require 'rails_helper'

RSpec.describe Article, :type => :model do

  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:title) }

  it { should allow_value('http://viget.com', 'https://viget.com').for(:url) }
  it { should_not allow_value('afdsafdsf', 'ftp://something').for(:url) }
end
