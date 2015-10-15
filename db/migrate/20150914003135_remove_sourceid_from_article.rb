class RemoveSourceidFromArticle < ActiveRecord::Migration
  def change
    remove_column :articles, :Source_id, :integer
  end
end
