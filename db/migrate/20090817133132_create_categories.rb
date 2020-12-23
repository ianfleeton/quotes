class CreateCategories < ActiveRecord::Migration[4.2]
  def self.up
    create_table :categories do |t|
      t.string :name
      t.integer :profile_id, :default => 0, :null => false
      t.integer :position, :default => 0, :null => false

      t.timestamps
    end
    add_index :categories, :profile_id
  end

  def self.down
    drop_table :categories
  end
end
