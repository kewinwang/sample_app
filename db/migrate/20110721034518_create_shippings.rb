class CreateShippings < ActiveRecord::Migration
  def self.up
    create_table :shippings do |t|
      t.string :provience
      t.string :city
      t.string :county
      t.string :streat_address
      t.string :zip
      t.string :receiver
      t.string :mobile
      t.string :comment
      t.reference :user

      t.timestamps
    end
  end

  def self.down
    drop_table :shippings
  end
end
