class AddAddressToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t| 
      t.string :address
    end
  end

  def self.down
    change_table :users do |t|  
      t.remove :address
    end
  end
end
