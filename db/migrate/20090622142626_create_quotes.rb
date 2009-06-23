class CreateQuotes < ActiveRecord::Migration
  def self.up
    create_table :quotes do |t|
      t.string :title, :default => '', :null => false
      t.string :reference, :default => '', :null => false
      t.string :to, :default => '', :null => false
      t.string :cc, :default => '', :null => false
      t.text :body, :default => '', :null => false
      t.datetime :sent_at

      t.timestamps
    end
  end

  def self.down
    drop_table :quotes
  end
end
