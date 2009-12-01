#
#  customer.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/11/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#

require 'data_base_model'

class Customer < DataBaseModel
	FIND_CUSTOMERS = "SELECT * FROM Customers"
	SAVE_CUSTOMERS = "INSERT INTO Customers "
	SALES_ITEM_CUST = "SELECT first_name,last_name,street_1,street_2,city,zip,email,phone,transaction_type,transaction_date FROM customers,items,copies,sales WHERE items.id = copies.item_id AND sales.copy_id = copies.id AND customer_id = customers.id "
	UPDATE_CUSTOMERS = "UPDATE Customers SET "
	
	attr_accessor :id,:first_name,:last_name,:street_1,:street_2,:city,:zip,:email,:phone,:transaction_date,:transaction_type
	attr_accessor :errors

	# Called when Customer.new is issued
	#
  def initialize(cells=nil)
	  unless cells.nil?
      cells.each_key do |key|
	      self.send("#{key}=",cells[key])
	    end
		end
  end
	
  def Customer.enter_with_form(customer_form)
    customer = Customer.new
		customer.first_name = customer_form.cellAtIndex_(0).stringValue
		customer.last_name = customer_form.cellAtIndex_(1).stringValue
		customer.street_1 = customer_form.cellAtIndex_(2).stringValue
		customer.street_2 = customer_form.cellAtIndex_(3).stringValue
		customer.city = customer_form.cellAtIndex_(4).stringValue
		customer.zip = customer_form.cellAtIndex_(5).stringValue
		customer.phone = customer_form.cellAtIndex_(6).stringValue
		customer.email = customer_form.cellAtIndex_(7).stringValue		
		customer.id = customer_form.cellAtIndex_(8).stringValue
		customer
	end
	
	# Combines the first and last names
	#
	def full_name
	  name = ""
	  name = name + "#{first_name}" if !first_name.nil? || !first_name.empty?
	  name = name + " #{last_name}" if !last_name.nil? || !last_name.empty?
		name.gsub(/^ /,'')
	end
			
	# Inserts the current values of a user instance into the table
	# If the user already exists then it just updates that user.
	#
	def save
	  if self.id.nil? || self.id.empty?
	    create
		else
		  update
		end
	end
	
	def update
	  esc_id = Customer.mysql.escape_string(self.id.to_s)
	  sets = ""
		attrs = [:first_name,:last_name,:street_1,:street_2,:city,:zip,:email,:phone]
		index = 0

		attrs.each do |key|
		  index = index + 1
			value = Customer.mysql.escape_string(self.send("#{key}").to_s)
			next if value.nil? || value.to_s == ""
			sets = sets + key.to_s + " = '" + value + "'," 
		end
		
		sets = sets.gsub(/,$/,'')
		query = UPDATE_CUSTOMERS + sets + "WHERE id = #{esc_id}"

		puts query #DEBUG
		errors = Customer.mysql.query(query)
		errors.nil?
	end
	
	def create
	  insert_attrs = "("
		insert_values = " VALUES ("
		attrs = [:first_name,:last_name,:street_1,:street_2,:city,:zip,:email,:phone]
		
		index = 0
		attrs.each do |key|
		  index = index + 1
			value = Customer.mysql.escape_string(self.send("#{key}").to_s)
			next if value.nil? || value.to_s == ""
			insert_attrs = insert_attrs + key.to_s + ','
			insert_values = insert_values + "'" + value + "',"
		end
		insert_values = insert_values.gsub(/,$/,'') + ")"
		insert_attrs = insert_attrs.gsub(/,$/,'') + ") "
		query = SAVE_CUSTOMERS + insert_attrs + insert_values
		puts query #DEBUG
		errors = Customer.mysql.query(query)
		errors.nil?
	end
	
	# Querys for customers based on the first_name and last_name
	#
	def Customer.find_by_name(l_name, f_name)
	  data = []
		if !l_name.nil? && !f_name.nil?
	    esc_last_name = Customer.mysql.escape_string(l_name.to_s) # Saftey First :)
	    esc_first_name = Customer.mysql.escape_string(f_name.to_s) 		
		  find_query = FIND_CUSTOMERS + " WHERE last_name LIKE '%#{esc_last_name}%'"
		  find_query = find_query + " AND first_name LIKE '%#{esc_first_name}%'"
		elsif !f_name.nil?
	    esc_first_name = Customer.mysql.escape_string(f_name.to_s) # Saftey First :)		
		  find_query = FIND_CUSTOMERS + " WHERE first_name LIKE '%#{esc_first_name}%'"
    elsif !l_name.nil?
	    esc_last_name = Customer.mysql.escape_string(l_name.to_s) # Saftey First :)		
		  find_query = FIND_CUSTOMERS + " WHERE last_name LIKE '%#{esc_last_name}%'"
    end		
		if find_query
  		res = Customer.mysql.query(find_query) 
	  	puts find_query #DEBUG
      res.each_hash do |h|
	      data << Customer.new(h)
      end
		end
		data
	end
	
	# Querys for customers based on the id
	#
	def Customer.find_by_id(cust_id)
	  data = nil
		if !cust_id.nil?
	    esc_cust_id = Customer.mysql.escape_string(cust_id.to_s) # Saftey First :)
			find_query = FIND_CUSTOMERS + " WHERE customers.id = #{esc_cust_id}"
    end		
		if find_query
	  	puts find_query #DEBUG
  		res = Customer.mysql.query(find_query) 
      res.each_hash do |h|
	      data = Customer.new(h)
      end
		end
		data
	end
	
	
	# Returns the last sale object that has customer_id = customer_id.
	#
  def Customer.find_by_item_id(item_id)
    data = []
		item_id = Customer.mysql.escape_string(item_id)
		sql_query = SALES_ITEM_CUST + " AND item_id = #{item_id} ORDER BY transaction_type,transaction_date"
		puts sql_query #DEBUG
		res = Customer.mysql.query(sql_query)
    res.each_hash do |h|
	    data << Customer.new(h)
    end
    return data
  end
	

	
end
