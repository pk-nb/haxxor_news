class Article < ActiveRecord::Base
  PER_PAGE = 20
  validates :url, :title, presence: true
  validates_format_of :url, :with => URI::regexp(%w(http https))
end
