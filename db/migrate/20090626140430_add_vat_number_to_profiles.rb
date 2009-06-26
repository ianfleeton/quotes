class AddVatNumberToProfiles < ActiveRecord::Migration
  def self.up
    add_column :profiles, :vat_number, :string, :default => '', :null => false
  end

  def self.down
    remove_column :profiles, :vat_number
  end
end
