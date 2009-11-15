
class Customer < ActiveRecord::Base
  validates_presence_of :first_name
  validates_presence_of :last_name   
  
  has_many :sales
  has_many :copies, :through => :sales
  has_many :items, :finder_sql => 'SELECT items.id,title,year,genre,item_type from items, sales, copies WHERE 
                 sales.copy_id=copies.id AND copies.item_id = items.id
                 AND sales.customer_id=#{id}'
end

