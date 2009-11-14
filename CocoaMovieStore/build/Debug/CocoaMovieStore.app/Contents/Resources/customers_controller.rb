#
#  CustomersController.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/11/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#
require 'osx/cocoa'

class CustomersController < OSX::NSObject
  ib_outlets :customers_box, :new_customer_box, :edit_customer_box, :new_edit_box, :cust_box_label
  ib_outlets :find_customer_text_field, :find_customer_box, :customer_form, :new_cust_error_label
  
  ib_action :new_customer
  def new_customer
    @new_edit_box.setHidden_(true)
    @new_customer_box.setHidden_(false)
  end
  
  ib_action :create_customer
  def create_customer
    puts("Create New Customer")
	customer = Customer.new_with_form(@customer_form)
	begin
	  if customer.save
	    puts "CustomerController: Saved Customer with id #{customer.id}"
		reset_customers
		@cust_box_label.setStringValue("Successfully added new customer to the system")
	  else
	    puts "CustomerController: failed to save customer"
		error_text = ''
		customer.errors.full_messages.each do |error_msg|
		  error_text += error_msg + "\n"
		end
	    @new_cust_error_label.setStringValue(error_text)
	  end
	rescue Exception => e
	  puts e
	  OSX::NSApp.terminate(self)
	end
  end
  
  ib_action :edit_customer
  def edit_customer
    @new_edit_box.setHidden_(true)
    @find_customer_box.setHidden_(false)
  end
  
  ib_action :find_customer
  def find_customer
  end
  
  ib_action :reset_customers
  def reset_customers
    @find_customer_text_field.setStringValue("")
    @new_edit_box.setHidden_(false)
    @find_customer_box.setHidden_(true)
    @customers_box.setHidden_(false)
	@new_cust_error_label.setStringValue("")
	@cust_box_label.setStringValue("") unless @cust_box_label.nil?
	reset_new_customer_box
  end
  
  private
  def reset_new_customer_box
    @new_customer_box.setHidden_(true)
	for i in 0..7
      @customer_form.cellAtIndex_(i).setStringValue("")
	end
  end
end