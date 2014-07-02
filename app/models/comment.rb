class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article

  validates :article_id, presence: true
  validates :body, presence: true, length: { minimum: 1 }
end
