class AddParentCommentToComment < ActiveRecord::Migration
  def change
    add_reference :comments, :parent
  end
end
