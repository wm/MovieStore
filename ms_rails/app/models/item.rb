class Item < ActiveRecord::Base
  has_many :copies
  # based on the BITMAP [DAPO] with each set to 0 or 1.
  has_and_belongs_to_many :actors, :class_name => "Celebrity", :conditions => ["position REGEXP ?", ".1.."]
  has_and_belongs_to_many :directors, :class_name => "Celebrity", :conditions => ["position REGEXP ?", "1..."]
  has_and_belongs_to_many :producers, :class_name => "Celebrity", :conditions => ["position REGEXP ?", "..1."]
  has_and_belongs_to_many :other_people, :class_name => "Celebrity", :conditions => ["position REGEXP ?", "...1"]
  has_and_belongs_to_many :celebrities
  has_and_belongs_to_many :studios
  has_many :sales, :through => :copies
  has_many :customers, :finder_sql => 'SELECT customers.id,first_name,last_name,street_1,street_2,city,zip,email,phone from customers, sales, copies WHERE 
                 sales.copy_id=copies.id AND sales.customer_id = customers.id
                 AND copies.item_id=#{id}'
end
