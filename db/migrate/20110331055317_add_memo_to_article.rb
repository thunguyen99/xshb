class AddMemoToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :memo, :text
  end

  def self.down
    remove_column :articles, :memo
  end
end
