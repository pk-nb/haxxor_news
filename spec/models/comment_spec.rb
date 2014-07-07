require 'spec_helper'

RSpec.describe Comment do
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:commentable_id) }
  it { should validate_presence_of(:commentable_type) }
  it { should ensure_length_of(:body).is_at_least(1) }
end
