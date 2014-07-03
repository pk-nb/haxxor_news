class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article

  has_many :replies, class_name: 'Comment', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Comment'

  validates :article_id, presence: true
  validates :body, presence: true, length: { minimum: 1 }
end
