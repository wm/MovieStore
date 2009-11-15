class CreateCelebritiesItems < ActiveRecord::Migration
  def self.up
    create_table :celebrities_items, :id => false do |t|
      t.integer :item_id
      t.integer :celebrity_id
    end
  end

  def self.down
    drop_table :celebrities_items
  end
end