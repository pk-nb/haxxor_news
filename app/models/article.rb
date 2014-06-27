class Article < ActiveRecord::Base
  belongs_to :user

  attr_writer :user_id

  PER_PAGE = 20
  validates :url, :title, presence: true
  validates_format_of :url, :with => URI::regexp(%w(http https))
end
