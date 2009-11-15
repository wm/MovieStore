class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :street_1
      t.string :street_2
      t.string :city
      t.string :zip
      t.string :email
      t.string :phone
    end
  end

  def self.down
    drop_table :customers
  end
end
