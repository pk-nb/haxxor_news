class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: [:votable_id, :votable_type] }
  validates :votable_id, presence: true
  validates :votable_type, presence: true
  validates :direction, inclusion: { in: [-1, 1] }

  def upvote?
    self.direction == 1
  end

  def downvote?
    self.direction == -1
  end
end
