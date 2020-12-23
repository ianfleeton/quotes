class CreateProfiles < ActiveRecord::Migration[4.2]
  def self.up
    create_table :profiles do |t|
      t.string :name, :default => '', :null => false
      t.text :html, :null => false
      t.string :from, :default => '', :null => false
      t.string :subject, :default => '', :null => false
      t.text :intro, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
