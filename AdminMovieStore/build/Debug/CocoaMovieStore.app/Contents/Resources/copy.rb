#
#  copy.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/21/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#
require 'data_base_model'

class Copy < DataBaseModel
  # SQL Query to find all copies than are not missing or sold
	FIND_AVAILABLE_COPIES_W_SECTION = "SELECT DISTINCT * FROM Copies JOIN Sections ON section_id = Sections.id WHERE copies.id  NOT IN (SELECT copy_id FROM sales WHERE transaction_type  IN ('sale','lost'))"
	FIND_ALL_COPIES = "SELECT DISTINCT * FROM Copies"

  attr_accessor :id, :copy_type, :sale_price, :wholesale_price, :section_name, :location, :section_id, :item_id
  
	# Returns an array of Copy objects that have item_id = item_id.
	#
  def Copy.find_by_item_id(item_id)
    data = []
		item_id = Copy.mysql.escape_string(item_id)
		sql_query = FIND_AVAILABLE_COPIES_W_SECTION +  " AND item_id = #{item_id};"
		puts sql_query #DEBUG
		res = Copy.mysql.query(sql_query)
    res.each_hash do |h|
	    data << Copy.new(h)
    end
    return data
  end
	
	# Returns a Copy object that has id = id.
	#
	def Copy.find_by_id(copy_id)
    data = nil
		copy_id = Copy.mysql.escape_string(copy_id)
		sql_query = FIND_ALL_COPIES + " WHERE copies.id = #{copy_id};"
		puts sql_query #DEBUG
	  res = Copy.mysql.query(sql_query)
    res.each_hash do |h|
	    data = Copy.new(h)
    end
    return data
  end
  
	# Called when Copy.new is issued
	#
  def initialize(cells)
    cells.each_key do |key|
		  at = key
			at = "section_name" if at == "name"
	    self.send("#{at}=",cells[key])
	  end
  end

end
