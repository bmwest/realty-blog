class RemoveAuthorFromArticles < ActiveRecord::Migration[5.0]
  def change
    remove_column :articles, :author, :string
  end
end
