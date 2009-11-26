#
#  CustomersController.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/11/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#
require 'osx/cocoa'

class CustomersController < ApplicationController

	attr_accessor :customers, :customer
  ib_outlets :customers_box, :new_customer_box, :edit_customer_box, :new_edit_box, :cust_box_label
  ib_outlets :first_name_field, :last_name_field, :find_customer_box, :customer_form
	ib_outlets :new_cust_error_label, :info_box, :customers_table
  
	def initialize
	  @customers = nil
  end
	
	# Action which displays the new customer box
	#
  ib_action :new_customer
  def new_customer
    @new_edit_box.setHidden_(true)
    @new_customer_box.setHidden_(false)
  end
  
	# This action creates a customer based on the fields in the form
	#
  ib_action :create_customer
  def create_customer
    puts("Create New Customer") #DEBUG
		customer = Customer.enter_with_form(@customer_form)
	  begin
	    if customer.save
	      puts "CustomerController: Saved Customer with id #{customer.id}" #DEBUG
		    reset_customers
		    @cust_box_label.setStringValue("Successfully saved Customer with id #{customer.id}")
  	  else
	      puts "CustomerController: failed to save customer" #DEBUG
		    error_text = ''
		    customer.errors.full_messages.each do |error_msg|
	  	    error_text += error_msg + "\n"
		    end
		    @new_cust_error_label.setStringValue(error_text)
	    end
	  rescue Exception => e
		  puts e  #DEBUG - ERRORS
	    puts clean_backtrace(e)  #DEBUG - ERRORS
	    OSX::NSApp.terminate(self)
	  end
  end
  
	# Action which displays the search box
	#
  ib_action :edit_customer
  def edit_customer
    @new_edit_box.setHidden_(true)
    @find_customer_box.setHidden_(false)
  end
  
	# Search for a customer
	#
  ib_action :find_customer
  def find_customer
	  @info_box.setStringValue("")
	  f_name = @first_name_field.stringValue
	  l_name = @last_name_field.stringValue
		if !f_name.empty? && !l_name.empty?
		  @customers = Customer.find_by_name(l_name,f_name)
		elsif !f_name.empty?
		  @customers = Customer.find_by_name(nil,f_name)
		elsif !l_name.empty?
		  @customers = Customer.find_by_name(l_name,nil)
		else
		  @customers = nil
		end
		@info_box.setStringValue("No Customer found.") if @customers.nil? || @customers.empty?
		@customers_table.reloadData
  end
	
	# Edit the selected Customer
	#
	ib_action :edit_selected_customer
	def edit_selected_customer
	  unless @customers_table.selectedRow < 0
		  @info_box.setStringValue("")
			customer = @customers[@customers_table.selectedRow]
			@customer_form.cellAtIndex_(0).setStringValue(customer.first_name) if customer.first_name
		  @customer_form.cellAtIndex_(1).setStringValue(customer.last_name) if customer.last_name
			@customer_form.cellAtIndex_(2).setStringValue(customer.street_1) if customer.street_1
		  @customer_form.cellAtIndex_(3).setStringValue(customer.street_2) if customer.street_2
		  @customer_form.cellAtIndex_(4).setStringValue(customer.city) if customer.city
		  @customer_form.cellAtIndex_(5).setStringValue(customer.zip) if customer.zip
		  @customer_form.cellAtIndex_(6).setStringValue(customer.phone) if customer.phone
		  @customer_form.cellAtIndex_(7).setStringValue(customer.email) if customer.email
		  @customer_form.cellAtIndex_(8).setStringValue(customer.id)
			@find_customer_box.setHidden_(true)
      @new_customer_box.setHidden_(false)
		else
		  @info_box.setStringValue("You must select a customer from the table to edit.")
		end
	end
  
	# Reset customers_box 
	#
  ib_action :reset_customers
  def reset_customers
  	hide_boxes
    @first_name_field.setStringValue("")
    @last_name_field.setStringValue("")
		@customers = nil
		@customers_table.reloadData
    @new_edit_box.setHidden_(false)
    @find_customer_box.setHidden_(true)
    @customers_box.setHidden_(false)
	  @new_cust_error_label.setStringValue("")
	  @cust_box_label.setStringValue("") unless @cust_box_label.nil?
	  reset_new_customer_box
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
  
  private
	
	# Resets the new_customer_box to its initial state. i.e. it clears text fields.
	#
  def reset_new_customer_box
    @new_customer_box.setHidden_(true)
	  for i in 0..8
      @customer_form.cellAtIndex_(i).setStringValue("")
	  end
  end
end