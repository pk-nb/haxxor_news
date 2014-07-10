class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true

  validates :user_id, presence: true
  validates :votable_id, presence: true
  validates :votable_type, presence: true
  validates :direction, inclusion: { in: [-1, 1] }

end
