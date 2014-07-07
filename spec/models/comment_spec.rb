require 'spec_helper'

RSpec.describe Comment do
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:commentable_id) }
  it { should validate_presence_of(:commentable_type) }
end
