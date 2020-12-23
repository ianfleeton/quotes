class AddDomainToProfiles < ActiveRecord::Migration[4.2]
  def self.up
    add_column :profiles, :domain, :string, :default => '', :null => false
  end

  def self.down
    remove_column :profiles, :domain
  end
end
