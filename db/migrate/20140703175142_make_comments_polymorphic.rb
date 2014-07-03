class MakeCommentsPolymorphic < ActiveRecord::Migration
  def change
    remove_foreign_key :comments, :article
    remove_reference :comments, :parent
    remove_reference :comments, :article
    add_reference :comments, :commentable, polymorphic: true, null: false
  end
end
