#
#  CustomersController.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/11/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#

require 'osx/cocoa'

class CustomersController < OSX::NSObject
  ib_outlets :customers_box, :new_customer_box, :edit_customer_box, :new_edit_box
  ib_outlets :find_customer_text_field, :find_customer_box
  
  ib_action :new_customer
  def new_customer
    @new_edit_box.setHidden_(true)
    @new_customer_box.setHidden_(false)
  end
  
  ib_action :create_customer
  def create_customer
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
    @new_customer_box.setHidden_(true)
  end
end