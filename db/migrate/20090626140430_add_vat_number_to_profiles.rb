class AddVatNumberToProfiles < ActiveRecord::Migration[4.2]
  def self.up
    add_column :profiles, :vat_number, :string, :default => '', :null => false
  end

  def self.down
    remove_column :profiles, :vat_number
  end
end
