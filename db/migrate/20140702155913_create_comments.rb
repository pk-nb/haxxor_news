class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.references :user, index: true
      t.references :article, index: true, null: false
      t.foreign_key :users
      t.foreign_key :articles, dependent: :delete
      t.timestamps
    end
  end
end
