require 'spec_helper'

RSpec.describe Comment do
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:article_id) }
  it { should ensure_length_of(:body).is_at_least(1) }

  # it { should allow_value('<h1>Rendered Markdown</h1>').for(:body) }
  # it { should allow_value('<h2>Rendered Markdown</h2>').for(:body) }
  # it { should allow_value('<h6>Rendered Markdown</h6>').for(:body) }
  # it { should allow_value('<p>Rendered Markdown</p>').for(:body) }
  # it { should allow_value('<a href="http://elsewhere.com">Link</a>').for(:body) }
  # it { should allow_value('<strong><em>WHAT</em></strong>').for(:body) }
  # it { should allow_value('<img src="http://gifs.com/my.gif">').for(:body) }
  # it { should allow_value('<ul><li>hi</li><li>hi</li></ul>').for(:body) }
  #
  # it { should_not allow_value('<hr/>') }
  # it { should_not allow_value('<h1 style="font-size:20em;">Custom styles</h1>') }
  # it { should_not allow_value('<script src="http://external.com/bad.js">').for(:body) }
end
