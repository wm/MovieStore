#
#  customer.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/11/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#

require 'activerecord'
require 'yaml'

dbconfig = YAML::load(File.open('../../database.yml'))
ActiveRecord::Base.establish_connection(dbconfig)
ActiveRecord::Base.logger = Logger.new(STDERR)
puts dbconfig
class Customer < ActiveRecord::Base

  def Customer.new_with_form(customer_form)
    customer = Customer.new
	
	customer
  end
end
