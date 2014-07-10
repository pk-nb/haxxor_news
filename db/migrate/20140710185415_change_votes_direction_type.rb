class ChangeVotesDirectionType < ActiveRecord::Migration
  def change
    # TODO change direction to integer with [-1,+1]
    remove_column :votes, :direction
    add_column :votes, :direction, :integer
    execute 'ALTER TABLE votes ADD CONSTRAINT check_vote_value CHECK (direction IN (-1, 1))'
  end
end
