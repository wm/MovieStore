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
	FIND_ALL_COPIES = "SELECT DISTINCT copies.id,item_id,copy_type,sale_price,wholesale_price,section_id,name,location FROM Copies JOIN Sections ON section_id = Sections.id"
	INSERT_COPY = "INSERT INTO Copies "
	UPDATE_COPY = "UPDATE Copies SET "
	FIND_SECTION = "SELECT id FROM Sections "
	INSERT_SECTION = "INSERT INTO Sections "
	DELETE_COPY = "DELETE FROM Copies "

  attr_accessor :id, :copy_type, :sale_price, :wholesale_price, :section_name, :location, :section_id, :item_id
	
	# Creating 
	#
	def create_new_copy
	  @transaction_date = Time.now.strftime("%Y-%M-%d")
	  insert_attrs = "("
		insert_values = " VALUES ("
		attrs = [:id, :copy_type, :sale_price, :wholesale_price, :section_id, :item_id]
		self.section_id = self.get_section_id
		
		index = 0
		attrs.each do |key|
		  index = index + 1
			value = Copy.mysql.escape_string(self.send("#{key}").to_s)
			next if value.nil? || value.to_s == ""
			insert_attrs = insert_attrs + key.to_s + ','
			insert_values = insert_values + "'" + value + "',"
		end
		
		insert_values = insert_values.gsub(/,$/,'') + ")"
		insert_attrs = insert_attrs.gsub(/,$/,'') + ") "
		query = INSERT_COPY + insert_attrs + insert_values
		puts query #DEBUG
		errors = Copy.mysql.query(query)
		errors.nil?
	end
	
	# Updating
	#
	def update
	  esc_id = Copy.mysql.escape_string(self.id.to_s)
	  sets = ""
		attrs = [:copy_type, :sale_price, :wholesale_price, :section_id, :item_id]
		index = 0
		self.section_id = self.get_section_id

		attrs.each do |key|
		  index = index + 1
			value = Copy.mysql.escape_string(self.send("#{key}").to_s)
			next if value.nil? || value.to_s == ""
			sets = sets + key.to_s + " = '" + value + "'," 
		end
		
		sets = sets.gsub(/,$/,'')
		query = UPDATE_COPY + sets + " WHERE id = #{esc_id}"

		puts query #DEBUG
		errors = Copy.mysql.query(query)
		errors.nil?
	end
	
	# Returns an array of Copy objects that have item_id = item_id.
	#
  def Copy.find_by_item_id(item_id)
    data = []
		item_id = Copy.mysql.escape_string(item_id)
		sql_query = FIND_ALL_COPIES +  " WHERE item_id = #{item_id};"
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
  
	# find the section id based on the section_name
	#
	def get_section_id
	  section_id_found = nil
	  section_name = Copy.mysql.escape_string(@section_name.to_s)
	  sql_query = FIND_SECTION + " WHERE name = '#{section_name}'"
		puts sql_query  #DEBUG
	  res = Copy.mysql.query(sql_query)
    res.each_hash do |h|
	    section_id_found = h['id']
    end
		if section_id_found.nil?
		  insert_section_name = Copy.mysql.escape_string(section_name)
		  res = Copy.mysql.query(INSERT_SECTION + "(name) VALUES ('#{insert_section_name}')")
			section_id_found = get_section_id
		end
		section_id_found
	end
	
	# Delete a record
	#
	def delete
	  puts DELETE_COPY + "WHERE copies.id = #{@id}"  #DEBUG
		Copy.mysql.query(DELETE_COPY + "WHERE copies.id = #{@id}")
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
