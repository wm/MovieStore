class CreateCopies < ActiveRecord::Migration
  def self.up
    create_table :copies do |t|
      t.integer :item_id
      t.string :copy_type
      t.float :sale_price
      t.float :wholesale_price
      t.integer :section_id
    end
  end

  def self.down
    drop_table :copies
  end
end
