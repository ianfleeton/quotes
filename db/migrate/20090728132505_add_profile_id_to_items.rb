class AddProfileIdToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :profile_id, :integer
    add_index :items, :profile_id
  end

  def self.down
    remove_index :items, :profile_id
    remove_column :items, :profile_id
  end
end
