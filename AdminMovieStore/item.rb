#
#  item.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/16/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#

require 'data_base_model'

class Item < DataBaseModel
	FIND_ITEMS_QUERY = "SELECT * FROM Items"
	INSERT_ITEM = "INSERT INTO Items "
  UPDATE_ITEMS = "UPDATE Items SET "
	DELETE_ITEM = "DELETE FROM Items "
	
  attr_accessor :id, :title, :year, :genre, :item_type
		
	# Creating 
	#
	def create_new_item
	  @transaction_date = Time.now.strftime("%Y-%M-%d")
	  insert_attrs = "("
		insert_values = " VALUES ("
		attrs = [:id, :title, :year, :genre, :item_type]
		
		index = 0
		attrs.each do |key|
		  index = index + 1
			value = Item.mysql.escape_string(self.send("#{key}").to_s)
			next if value.nil? || value.to_s == ""
			insert_attrs = insert_attrs + key.to_s + ','
			insert_values = insert_values + "'" + value + "',"
		end
		
		insert_values = insert_values.gsub(/,$/,'') + ")"
		insert_attrs = insert_attrs.gsub(/,$/,'') + ") "
		query = INSERT_ITEM + insert_attrs + insert_values
		puts query #DEBUG
		errors = Item.mysql.query(query)
		errors.nil?
	end
	
	# Updating
	#
	def update
	  esc_id = Item.mysql.escape_string(self.id.to_s)
	  sets = ""
		attrs = [:id, :title, :year, :genre, :item_type]
		index = 0

		attrs.each do |key|
		  index = index + 1
			value = Item.mysql.escape_string(self.send("#{key}").to_s)
			next if value.nil? || value.to_s == ""
			sets = sets + key.to_s + " = '" + value + "'," 
		end
		
		sets = sets.gsub(/,$/,'')
		query = UPDATE_ITEMS + sets + "WHERE id = #{esc_id}"

		puts query #DEBUG
		errors = Item.mysql.query(query)
		errors.nil?
	end
	
	def Item.find_by_id(item_id)
	  data = nil
		item_id = Item.mysql.escape_string(item_id)
		find_query = FIND_ITEMS_QUERY + " WHERE id = #{item_id}"
		puts find_query
	  
		res = Item.mysql.query(find_query)
    res.each_hash do |h|
	    data = Item.new(h)
    end
		data
	end
	
  def Item.find_with_conditions(conditions=nil)
    data = []
		find_query = FIND_ITEMS_QUERY
		if !conditions.nil? && !conditions.empty? && !conditions[:id].nil?
		  esc_item_id = Item.mysql.escape_string(conditions[:id].to_s)
		  find_query = find_query + " WHERE items.id = #{esc_item_id}"
		else
			# Update the query to filter on genre, year, and title
			unless conditions.nil? || conditions.empty?
				find_query = find_query + " WHERE ("
				index = 0
				
				conditions.each do |key,value|
					index = index + 1
					esc_value = Item.mysql.escape_string(value.to_s) # Saftey First :)
					find_query = find_query + "#{key} LIKE '%#{esc_value}%'"
					find_query = find_query + " AND " if index < conditions.length
				end	
				
				find_query = find_query + ")"				
			end
		end
		# DEBUGING
		puts find_query
	  
		res = Item.mysql.query(find_query)
    res.each_hash do |h|
	    data << Item.new(h)
    end
		
    data
  end
	
	def delete
	  puts DELETE_ITEM + "WHERE items.id = #{@id}"
		Item.mysql.query(DELETE_ITEM + "WHERE items.id = #{@id}")
	end
  
	# Called when Item.new is issued
	#
  def initialize(cells)
    cells.each_key do |key|
	    self.send("#{key}=",cells[key])
	  end
  end
  
  private
	
	
	# Convert the actor and director portions of conditions to a clause of an SQL query.
	# Remove the actor and director search fields from the conditions
	#
	# Returns the generated filtering clause as a string or nil if no actor/director values
	#
	def Item.actor_director_query(conditions)
	  return nil if conditions.nil?
		query = nil
		
		conditions.each do |key,value|
			if (!conditions[:actors].nil?  && !conditions[:directors].nil?)
        # Saftey First :)			
        a_last_name = Item.mysql.escape_string(conditions.delete(:actors).to_s)				
			  d_last_name = Item.mysql.escape_string(conditions.delete(:directors).to_s)
				query = " AND item_id IN ( SELECT item_id from celebrities_items WHERE celebrity_id IN ( select id FROM celebrities where (last_name LIKE '%#{d_last_name}%' AND position REGEXP '1...'))) AND item_id IN ( SELECT item_id from celebrities_items WHERE celebrity_id IN (  select id FROM celebrities where (last_name LIKE '%#{a_last_name}%' AND position REGEXP '.1..') ) )"
			elsif !conditions[:actors].nil?
			  a_last_name = Item.mysql.escape_string(conditions.delete(:actors).to_s)
				query = " AND item_id IN ( SELECT item_id from celebrities_items WHERE celebrity_id IN (select id FROM celebrities where last_name LIKE '%#{a_last_name}%' AND position REGEXP '.1..') )"
			elsif !conditions[:directors].nil?
        d_last_name = Item.mysql.escape_string(conditions.delete(:directors).to_s)
				query = " AND item_id IN ( SELECT item_id from celebrities_items WHERE celebrity_id IN (select id FROM celebrities where last_name LIKE '%#{d_last_name}%' AND position REGEXP '1...') )"
			end
		end
		
    query
	end
end
