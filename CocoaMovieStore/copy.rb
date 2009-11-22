#
#  copy.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/21/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#
require '/opt/local/mysql-ruby/mysql-ruby-2.8.1/mysql.o'

class Copy
 attr_accessor :id, :copy_type, :sale_price, :wholesale_price, :section_name, :location, :section_id, :item_id
  
  def Copy.find_by_item_id(item_id)
    data = []
	  res = Copy.mysql.query("SELECT * FROM Copies JOIN Sections ON section_id = Sections.id WHERE item_id = #{item_id}")
    res.each_hash do |h|
	    data << Copy.new(h)
    end
    return data
  end
	
	def Copy.find_by_id(id)
    data = []
	  res = Copy.mysql.query("SELECT * FROM Copies JOIN Sections ON section_id = Sections.id WHERE id = #{id}")
    res.each_hash do |h|
	    data << Copy.new(h)
    end
    return data
  end
  
  def initialize(cells)
    cells.each_key do |key|
		  at = key
			at = "section_name" if at == "name"
	    self.send("#{at}=",cells[key])
	  end
  end
  
	private
  def Copy.mysql
    if @m.nil?
      @m = Mysql.connect('localhost', 'wmernagh', 'water7932', 'movie_store')
    end
    @m	
  end

end
