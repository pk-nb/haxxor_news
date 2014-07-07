class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :commentable

  PER_PAGE = 20
  validates :url, :title, presence: true
  validates_format_of :url, :with => URI::regexp(%w(http https))
  validates_length_of :title, in: 1..255

  def comment_count
    self.comments.inject(self.comments.count) { |sum, comment| sum + comment.reply_count }
  end
end
