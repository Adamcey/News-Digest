class CreateEmailings < ActiveRecord::Migration
  def change
    create_table :emailings do |t|
      t.string :username
      t.string :article_title
      t.integer :user_id
      t.integer :article_id

      t.timestamps null: false
    end
  end
end
