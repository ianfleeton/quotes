class AddProfileIdToQuotes < ActiveRecord::Migration
  def self.up
    add_column :quotes, :profile_id, :integer
    add_index :quotes, :profile_id
  end

  def self.down
    remove_index :quotes, :profile_id
    remove_column :quotes, :profile_id
  end
end
