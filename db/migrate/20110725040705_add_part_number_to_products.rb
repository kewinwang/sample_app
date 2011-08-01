class AddPartNumberToProducts < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
      t.string :part_number 
    end
  end

  def self.downi
    change_table :products do |t|
      t.remove  :part_number
    end
  end
end
