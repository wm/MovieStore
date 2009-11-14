class CreateMedia < ActiveRecord::Migration
  def self.up
    create_table :media do |t|
      t.string :title
      t.date :year
      t.string :genre
      t.string :media_type

      t.timestamps
    end
  end

  def self.down
    drop_table :media
  end
end
