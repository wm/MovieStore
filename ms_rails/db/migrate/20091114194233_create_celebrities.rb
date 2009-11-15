class CreateCelebrities < ActiveRecord::Migration
  def self.up
    create_table :celebrities do |t|
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.string :position
    end
  end

  def self.down
    drop_table :celebrities
  end
end
