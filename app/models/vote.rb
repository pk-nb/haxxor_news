class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true

  def score
    # find all votes with same parent type and id
    # return tally of +1 and -1
  end
end
