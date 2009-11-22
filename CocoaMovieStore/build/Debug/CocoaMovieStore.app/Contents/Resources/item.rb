#
#  item.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/16/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#

require '/opt/local/mysql-ruby/mysql-ruby-2.8.1/mysql.o'

class Item 
	FIND_ALL_QUERY = "SELECT DISTINCT Items.id,title,year,genre from Items,Celebrities,Celebrities_Items WHERE Items.id = Celebrities_Items.item_id AND Celebrities.id = Celebrities_Items.celebrity_id"

  attr_accessor :id, :title, :year, :genre, :item_type
	
  def Item.find_with_conditions(conditions=nil)
    data = []
		find_query = FIND_ALL_QUERY
		
		# Update the query to filter by actors and/or directors
		ad_query = Item.actor_director_query(conditions)
		find_query = find_query + "#{ad_query}" unless ad_query.nil?
		
		# Update the query to filter on genre, year, and title
		unless conditions.blank?
		  find_query = find_query + " AND ("
			index = 0
		  
			conditions.each do |key,value|
				index = index + 1
				esc_value = Item.mysql.escape_string(value.to_s) # Saftey First :)
				find_query = find_query + "#{key} LIKE '%#{esc_value}%'"
				find_query = find_query + " AND " if index < conditions.length
			end	
		  
			find_query = find_query + ")"				
		end
		
		# DEBUGING
		puts find_query
	  
		res = Item.mysql.query(find_query)
    res.each_hash do |h|
	    data << Item.new(h)
    end
		
    data
  end
  
	# Called when Item.new is issued
	#
  def initialize(cells)
    cells.each_key do |key|
	    self.send("#{key}=",cells[key])
	  end
  end
  
  private
	
	# The MySQL query connection
	#
  def Item.mysql
    if @m.nil?
      @m = Mysql.connect('localhost', 'wmernagh', 'water7932', 'movie_store')
    end
    @m	
  end
	
	# Convert the actor and director portions of conditions to a clause of an SQL query.
	# Remove the actor and director search fields from the conditions
	#
	# Returns the generated filtering clause as a string or nil if no actor/director values
	#
	def Item.actor_director_query(conditions)
	  return nil if conditions.nil?
		query = nil
		
		conditions.each do |key,value|
			if (!conditions[:actors].blank? && !conditions[:directors].blank?)
        # Saftey First :)			
        a_last_name = Item.mysql.escape_string(conditions.delete(:actors).to_s)				
			  d_last_name = Item.mysql.escape_string(conditions.delete(:directors).to_s)
				query = " AND item_id IN ( SELECT item_id from celebrities_items WHERE celebrity_id IN ( select id FROM celebrities where (last_name LIKE '%#{d_last_name}%' AND position REGEXP '1...'))) AND item_id IN ( SELECT item_id from celebrities_items WHERE celebrity_id IN (  select id FROM celebrities where (last_name LIKE '%#{a_last_name}%' AND position REGEXP '.1..') ) )"
			elsif !conditions[:actors].blank?
			  a_last_name = Item.mysql.escape_string(conditions.delete(:actors).to_s)
				query = " AND item_id IN ( SELECT item_id from celebrities_items WHERE celebrity_id IN (select id FROM celebrities where last_name LIKE '%#{a_last_name}%' AND position REGEXP '.1..') )"
			elsif !conditions[:directors].blank?
        d_last_name = Item.mysql.escape_string(conditions.delete(:directors).to_s)
				query = " AND item_id IN ( SELECT item_id from celebrities_items WHERE celebrity_id IN (select id FROM celebrities where last_name LIKE '%#{d_last_name}%' AND position REGEXP '1...') )"
			end
		end
		
    query
	end
end
