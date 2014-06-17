class Article < ActiveRecord::Base
  validates :url, :title, presence: true
  validates_format_of :url, :with => URI::regexp(%w(http https))
end
