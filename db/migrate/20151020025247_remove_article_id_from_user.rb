class RemoveArticleIdFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :article_id, :integer
  end
end
