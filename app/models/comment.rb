class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many :replies, class_name: 'Comment', as: :commentable

  validates :commentable_id, presence: true
  validates :commentable_type, presence: true
  validates :body, presence: true, length: { minimum: 1 }

  def count_with_replies
    tally_replies(self)
  end

  private
  def tally_replies(comment)
    comment.replies.inject(comment.replies.count) { |sum, reply| sum + reply.replies.count }
  end
end
