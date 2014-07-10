class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :direction
      t.belongs_to :user, null: false
      t.references :votable, polymorphic: true, null: false
      t.foreign_key :users, dependent: :destroy
      t.timestamps
    end
  end
end
