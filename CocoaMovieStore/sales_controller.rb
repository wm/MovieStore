#
#  sales_controller.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/22/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#
require 'osx/cocoa'

class SalesController < ApplicationController
 
	attr_accessor :customers, :copy, :item, :customer, :last_sale
	ib_outlets :first_name_field, :last_name_field, :item_id_field
	ib_outlets :price_field, :format_field, :title_field, :type_field	
  ib_outlets :sale_box, :info_box, :customers_table, :notification_label, :status_label
	
	def initialize
	  @customers = nil
    @copy = nil
		@item = nil
	end
  
	# Record the sale if correct information is provided.
	#
  ib_action :make_sale
  def make_sale
		if check_customer_selected && check_item_being_sold	
		  @customer = @customers[@customers_table.selectedRow]
			sale = Sale.new({:copy_id => @copy.id,:customer_id => @customer.id,:transaction_type => "sale", :transaction_ammount => @copy.sale_price, :employee_id => $employee_id})
      begin
				if sale.save
					message = "#{@customer.full_name} successfully purchased a copy of #{@item.title} for $#{@copy.sale_price}"
					reset_sales_stuff
					@notification_label.setStringValue(message)
				else
					@notification_label.setStringValue("#{sale.error_message}")
				end
			rescue Exception => e
			  model_exception e,@status_label
	    end
		end
	end
	
	# Record the return if correct information is provided.
	# 
	ib_action :make_return
  def make_return	
		if check_customer_selected	&& check_item_being_returned
		  @customer = @customers[@customers_table.selectedRow]
			sale = Sale.new({:copy_id => @copy.id,:customer_id => @customer.id, :transaction_type => "return", :transaction_ammount => @copy.sale_price, :employee_id => $employee_id})
			begin
				if sale.save
					message = "#{@customer.full_name} successfully returned a copy of #{@item.title}"
					reset_sales_stuff
					@notification_label.setStringValue(message)
				else
					@notification_label.setStringValue("#{sale.error_message}")
				end
			rescue Exception => e
			  model_exception e,@status_label
	    end
		end
	end

  # Search for Customer and product
	#
	ib_action :search
  def search
	  @notification_label.setStringValue("")
	  find_product
	  find_customer
		@customers_table.reloadData
  end
	
	# This method needs to be implemented by the dataSource of an NSTableView.
	# This function is used by the NSTableView to populate itself
	#
  def tableView_objectValueForTableColumn_row_(view, col, row)
			case col.identifier.to_s
			when "ID"
				return @customers[row].id
			when "FNAME"
				return @customers[row].first_name
			when "LNAME"
				return @customers[row].last_name
			when "STREET1"
				return @customers[row].street_1
			when "CITY"
				return @customers[row].city
			when "ZIP"
				return @customers[row].zip
			when "EMAIL"
				return @customers[row].email
			else
				return nil
			end
  end
  
	# This method needs to be implemented by the dataSource of an NSTableView.
	#
  def numberOfRowsInTableView_(view)
		return 0 if @customers.nil?
	  return @customers.length
	end
	
	# Hides all boxes in the view and then make the catalog_box visible
	# note that hide_boxes is inherited from ApplicationController
	#
  ib_action :reset_sales_returns_box
  def reset_sales_returns_box
	  hide_boxes
    @sales_returns_box.setHidden_(false)
  end
  
	# Hides the sales_returns_box
	#
  def hide_sales_returns_box
    @sales_returns_box.setHidden_(true)
  end
	
	private
	
	# Converts the search attributes into an array only containing those that have 
	# non-blank values
	#
	def gen_conditions
	  conditions = {}
		search_fields = [:title, :genre, :year, :directors, :actors]
		search_fields.each do |sf|
		  conditions[sf] = self.send(sf).stringValue unless self.send(sf).nil? || self.send(sf).stringValue == ""
		end
		(conditions.empty?) ? nil : conditions
	end
	
	def find_product
	  @price_field.setStringValue("")
		@format_field.setStringValue("")
		@title_field.setStringValue("")
		@type_field.setStringValue("")
		@status_label.setStringValue("")
		@copy = nil
	  copy_id = @item_id_field.stringValue
	  unless copy_id.nil? || copy_id.empty?
		  begin
  		  @copy = Copy.find_by_id(copy_id.to_s)
				unless @copy.nil?
					@item = Item.find_by_id(@copy.item_id)
					@type_field.setStringValue(@item.item_type)
					@title_field.setStringValue(@item.title)
					@format_field.setStringValue(@copy.copy_type)
					@price_field.setStringValue(@copy.sale_price)
				else
				  @notification_label.setStringValue("No product with this ID was found.")
				end
			rescue Exception => e
				reset_sales_stuff
				model_exception e,@status_label
			end
		end
  end
	
	def find_customer
	  fname = @first_name_field.stringValue
	  lname = @last_name_field.stringValue	
		begin	
			if !fname.nil? && !lname.nil? && !fname.empty? && !lname.empty?
				@customers = Customer.find_by_name(lname,fname)
			elsif !lname.nil? && !lname.empty?
				@customers = Customer.find_by_name(lname,nil)
			elsif !fname.nil? && !fname.empty?
				@customers = Customer.find_by_name(nil,fname)
			else
				@customers = nil
			end
		rescue Exception => e
			reset_sales_stuff
			model_exception e,@status_label			
		end
  end
	
	def check_customer_selected
	  fname = @first_name_field.stringValue
	  lname = @last_name_field.stringValue	
		if (fname.nil? && lname.nil?) || (fname.empty? && lname.empty?)
		  @notification_label.setStringValue("Please ask the customer for their name.")
			return false
		elsif @customers_table.selectedRow < 0
		  @notification_label.setStringValue("Please select a customer from the table or enter the customers details to the system.")
			return false
		else
		  @notification_label.setStringValue("") 
			return true
		end
	end
	
	def check_item_being_sold
	  if @item.nil?
		  @notification_label.setStringValue("Please provide a product number.")
			return false
		else
		  return true
		end
	end
	
	def check_item_being_returned
	  if @item.nil?
		  @notification_label.setStringValue("Please provide a product number.")
			return false
		else
		  @last_sale = Sale.find_last_by_copy_id(@copy.id)
			if @last_sale.nil? || @last_sale.transaction_type != "sale"
			  @notification_label.setStringValue("This product was not sold!!!.")
				return false
			else
			  @notification_label.setStringValue("")
		    return true
			end
		end
	end
	
	private
	
	# Reset to starting state
	#
	def reset_sales_stuff
	  @last_sale = nil
		@sale = nil
		@item = nil
		@copy = nil
		@customers = nil
		@first_name_field.setStringValue("")
		@last_name_field.setStringValue("")
		@item_id_field.setStringValue("")
		@price_field.setStringValue("")
		@format_field.setStringValue("")
		@title_field.setStringValue("")
		@type_field.setStringValue("")
		@notification_label.setStringValue("")	
		@status_label.setStringValue("")
		@customers_table.reloadData	
	end

end
