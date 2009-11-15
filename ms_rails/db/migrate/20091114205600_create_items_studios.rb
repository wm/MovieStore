class CreateItemsStudios < ActiveRecord::Migration
  def self.up
    create_table :items_studios, :id => false do |t|
      t.integer :item_id
      t.integer :studio_id
    end
  end

  def self.down
    drop_table :items_studios
  end
end