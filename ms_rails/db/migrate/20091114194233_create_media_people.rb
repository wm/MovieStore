class CreateMediaPeople < ActiveRecord::Migration
  def self.up
    create_table :media_people do |t|
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.string :position

      t.timestamps
    end
  end

  def self.down
    drop_table :media_people
  end
end
