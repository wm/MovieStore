#
#  sale.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/22/09.
#  Copyright (c) 2009. All rights reserved.
#

require 'data_base_model'

class Sale < DataBaseModel
  FIND_ALL = "SELECT * FROM Sales"
	SAVE_SALE = "INSERT INTO Sales "
	SALES_ITEM_COPY_CUST = "SELECT sales.id,title,year,genre,copy_type,sale_price AS price,wholesale_price,transaction_date,copies.id AS copy_id FROM sales,copies,items WHERE copies.id = sales.copy_id AND items.id = copies.item_id "

	attr_accessor :id, :customer_id, :copy_id, :employee_id, :transaction_date
	attr_accessor :coupon_note, :transaction_ammount, :transaction_type
	attr_accessor :error_message
	attr_accessor :title,:year,:genre,:copy_type,:price,:wholesale_price,:transaction_date,:copy_id
		
	# Called when Sale.new is issued
	#
  def initialize(cells)
    cells.each_key do |key|
	    self.send("#{key}=",cells[key])
	  end
  end
	
  # Returns the last sale object that has copy_id = copy_id.
	#
  def Sale.find_last_by_copy_id(copy_id)
    data = nil
		copy_id = Sale.mysql.escape_string(copy_id)
		sql_query = FIND_ALL + " WHERE copy_id = #{copy_id} ORDER BY transaction_date LIMIT 1;"
		puts sql_query #DEBUG
		res = Sale.mysql.query(sql_query)
    res.each_hash do |h|
	    data = Sale.new(h)
    end
    return data
  end
	
	# Returns the last sale object that has customer_id = customer_id.
	#
  def Sale.find_by_customer_id(customer_id)
    data = []
		customer_id = Sale.mysql.escape_string(customer_id)
		sql_query = SALES_ITEM_COPY_CUST + " AND customer_id = #{customer_id} ORDER BY transaction_date"
		puts sql_query #DEBUG
		res = Sale.mysql.query(sql_query)
    res.each_hash do |h|
	    data << Sale.new(h)
    end
    return data
  end
	
	#
	#
	def save
	  puts @copy_id + " " + @transaction_type + " " + @transaction_ammount + " " + @employee_id.to_s
		if create
		  @error_message = nil
	  else
	    @error_message = "Failed to complete transaction"
	    return false
		end
		return true
	end
	
	private
	
	# Creating 
	#
	def create
	  @transaction_date = Time.now.strftime("%Y-%M-%d")
	  insert_attrs = "("
		insert_values = " VALUES ("
		attrs = [:id, :customer_id, :copy_id, :employee_id, :transaction_date, :coupon_note, :transaction_ammount, :transaction_type]
		
		index = 0
		attrs.each do |key|
		  index = index + 1
			value = Sale.mysql.escape_string(self.send("#{key}").to_s)
			next if value.nil? || value.to_s == ""
			insert_attrs = insert_attrs + key.to_s + ','
			insert_values = insert_values + "'" + value + "',"
		end
		
		insert_values = insert_values.gsub(/,$/,'') + ")"
		insert_attrs = insert_attrs.gsub(/,$/,'') + ") "
		query = SAVE_SALE + insert_attrs + insert_values
		puts query #DEBUG
		errors = Sale.mysql.query(query)
		errors.nil?
	end
	
end
