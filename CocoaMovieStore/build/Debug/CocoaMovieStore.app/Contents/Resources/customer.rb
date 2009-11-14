#
#  customer.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/11/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#

require 'rubygems'
require 'activeresource'
require 'yaml'


class Customer < ActiveResource::Base
  #dbconfig = YAML::load(File.open('../../database.yml'))
  #establish_connection(dbconfig)
  #puts dbconfig
  
  self.site = 'http://localhost:3000'

  def Customer.new_with_form(customer_form)
    customer = Customer.new
		customer.first_name = customer_form.cellAtIndex_(0).stringValue()
		customer.last_name = customer_form.cellAtIndex_(1).stringValue()
		customer.street_1 = customer_form.cellAtIndex_(2).stringValue()
		customer.street_2 = customer_form.cellAtIndex_(3).stringValue()
		customer.city = customer_form.cellAtIndex_(4).stringValue()
		customer.zip = customer_form.cellAtIndex_(5).stringValue()
		customer.phone = customer_form.cellAtIndex_(6).stringValue()
		customer.email = customer_form.cellAtIndex_(7).stringValue()
		customer
	end
	
end
