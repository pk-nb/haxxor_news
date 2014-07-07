class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many :replies, class_name: 'Comment', as: :commentable

  validates :commentable_id, presence: true
  validates :commentable_type, presence: true
  validates :body, presence: true

  def reply_count
    if replies.any?
      replies.inject(replies.count) { |sum, reply| sum + reply.reply_count }
    else
      0
    end
  end

  def to_html
    @to_html ||= MarkdownRenderer.new.to_html(body)
  end

end
