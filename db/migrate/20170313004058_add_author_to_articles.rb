class AddAuthorToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :author, :string, null: false
  end
end
