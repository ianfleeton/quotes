class CreateUsers < ActiveRecord::Migration[4.2]
  def self.up
    create_table :users do |t|
      t.string  :email, :default => '', :null => false
      t.string  :name, :default => '', :null => false
      t.string  :encrypted_password, :default => '', :null => false
      t.string  :salt, :default => '', :null => false
      t.boolean :admin, :default => false, :null => false
      t.string  :forgot_password_token, :default => '', :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
