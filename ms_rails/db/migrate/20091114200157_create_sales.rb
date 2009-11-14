class CreateSales < ActiveRecord::Migration
  def self.up
    create_table :sales do |t|
      t.integer :copy_id
      t.string :customer_id
      t.date :transaction_date
      t.integer :employee_id
      t.string :transaction_type
      t.float :transaction_ammount
      t.string :coupon_note

      t.timestamps
    end
  end

  def self.down
    drop_table :sales
  end
end
