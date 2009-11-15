class Employee < ActiveRecord::Base
  has_many :transactions, :class_name => "Sale"
  has_many :sales, :class_name => "Sale", :conditions => ["type = ?", 'sale']
  has_many :returns, :class_name => "Sale", :conditions => ["type = ?", 'return']  
end
