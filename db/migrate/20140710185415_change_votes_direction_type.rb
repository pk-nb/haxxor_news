class ChangeVotesDirectionType < ActiveRecord::Migration
  def change
    remove_column :votes, :direction
    add_column :votes, :direction, :integer
    execute 'ALTER TABLE votes ADD CONSTRAINT check_vote_value CHECK (direction IN (-1, 1))'
  end
end
