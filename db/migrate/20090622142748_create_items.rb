class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name, :default => '', :null => false
      t.text :information, :default => '', :null => false
      t.integer :price, :default => 0, :null => false
      t.integer :position, :default => 0, :null => false

      t.timestamps
    end
    add_index :items, :position
  end

  def self.down
    drop_table :items
  end
end
