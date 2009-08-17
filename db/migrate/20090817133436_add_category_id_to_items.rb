class AddCategoryIdToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :category_id, :integer, :default => 0, :null => false
    add_index :items, :category_id
  end

  def self.down
    remove_index :items, :category_id
    remove_column :items, :category_id
  end
end
