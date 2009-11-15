class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :title
      t.date :year
      t.string :genre
      t.string :item_type
    end
  end

  def self.down
    drop_table :items
  end
end
