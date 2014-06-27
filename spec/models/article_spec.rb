require 'spec_helper'

RSpec.describe Article, :type => :model do

  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:title) }
  it { should ensure_length_of(:title).is_at_most(255) }

  describe 'URL validation' do
    it { should allow_value('http://viget.com', 'https://viget.com').for(:url) }
    it { should allow_value('http://pk-nb.github.io', 'http://her.bs').for(:url) }

    it { should_not allow_value('afdsafdsf', 'ftp://something').for(:url) }
    it { should_not allow_value('htt://google.com', 'ftp://hi.com').for(:url) }
  end

end
