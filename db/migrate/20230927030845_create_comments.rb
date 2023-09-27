class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.bigint :user_id, null: false
      t.bigint :post_id, null: false
      t.text :text

      t.timestamps
    end

    add_foreign_key :comments, :users
    add_foreign_key :comments, :posts
    add_index :comments, :user_id
    add_index :comments, :post_id
  end
end
