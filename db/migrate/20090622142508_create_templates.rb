class CreateTemplates < ActiveRecord::Migration
  def self.up
    create_table :templates do |t|
      t.string :name, :default => '', :null => false
      t.text :html, :default => '', :null => false
      t.string :from, :default => '', :null => false
      t.string :subject, :default => '', :null => false
      t.text :intro, :default => '', :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :templates
  end
end
