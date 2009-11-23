#
#  sale.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/22/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#

require 'data_base_model'

class Sale < DataBaseModel
  FIND_ALL = "SELECT * FROM Sales"
	attr_accessor :id, :customer_id, :copy_id, :employee_id, :transaction_date
	attr_accessor :coupon_note, :transaction_ammount, :transaction_type
		
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

end
