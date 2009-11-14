class CreateCopies < ActiveRecord::Migration
  def self.up
    create_table :copies do |t|
      t.integer :media_id
      t.string :copy_type
      t.float :sale_price
      t.float :wholesale_price
      t.integer :store_section_id

      t.timestamps
    end
  end

  def self.down
    drop_table :copies
  end
end
