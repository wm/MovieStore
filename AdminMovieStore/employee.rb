#
#  employee.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/26/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#

class Employee < DataBaseModel
	FIND_EMPLOYEES = "SELECT * FROM Employees"
	SAVE_EMPLOYEES = "INSERT INTO Employees "
	UPDATE_EMPLOYEES = "UPDATE Employees SET "
	
	attr_accessor :id,:first_name,:last_name,:position,:password,:enabled
	attr_accessor :errors

	# Called when employee.new is issued
	#
  def initialize(cells=nil)
	  unless cells.nil?
      cells.each_key do |key|
	      self.send("#{key}=",cells[key])
	    end
		end
  end
	
  def Employee.enter_with_form(employee_form)
    employee = Employee.new
		employee.first_name = employee_form.cellAtIndex_(0).stringValue
		employee.last_name = employee_form.cellAtIndex_(1).stringValue
		employee.street_1 = employee_form.cellAtIndex_(2).stringValue
		employee.street_2 = employee_form.cellAtIndex_(3).stringValue
		employee.city = employee_form.cellAtIndex_(4).stringValue
		employee.zip = employee_form.cellAtIndex_(5).stringValue
		employee.phone = employee_form.cellAtIndex_(6).stringValue
		employee.email = employee_form.cellAtIndex_(7).stringValue		
		employee.id = employee_form.cellAtIndex_(8).stringValue
		employee
	end
	
	# Combines the first and last names
	#
	def full_name
	  name = ""
	  name = name + "#{first_name}" if !first_name.nil? || !first_name.empty?
	  name = name + " #{last_name}" if !last_name.nil? || !last_name.empty?
		name.gsub(/^ /,'')
	end
			
	# Inserts the current values of a user instance into the table
	# If the user already exists then it just updates that user.
	#
	def save
	  if self.id.nil? || self.id.empty?
	    create
		else
		  update
		end
	end
	
	def update
	  esc_id = Employee.mysql.escape_string(self.id.to_s)
	  sets = ""
		attrs = [:first_name,:last_name,:street_1,:street_2,:city,:zip,:email,:phone]
		index = 0

		attrs.each do |key|
		  index = index + 1
			value = Employee.mysql.escape_string(self.send("#{key}").to_s)
			next if value.nil? || value.to_s == ""
			sets = sets + key.to_s + " = '" + value + "'," 
		end
		
		sets = sets.gsub(/,$/,'')
		query = UPDATE_EMPLOYEES + sets + "WHERE id = #{esc_id}"

		puts query #DEBUG
		errors = Employee.mysql.query(query)
		errors.nil?
	end
	
	def create
	  insert_attrs = "("
		insert_values = " VALUES ("
		attrs = [:first_name,:last_name,:street_1,:street_2,:city,:zip,:email,:phone]
		
		index = 0
		attrs.each do |key|
		  index = index + 1
			value = Employee.mysql.escape_string(self.send("#{key}").to_s)
			next if value.nil? || value.to_s == ""
			insert_attrs = insert_attrs + key.to_s + ','
			insert_values = insert_values + "'" + value + "',"
		end
		insert_values = insert_values.gsub(/,$/,'') + ")"
		insert_attrs = insert_attrs.gsub(/,$/,'') + ") "
		query = SAVE_EMPLOYEES + insert_attrs + insert_values
		puts query #DEBUG
		errors = Employee.mysql.query(query)
		errors.nil?
	end
	
	# Querys for employees based on the first_name and last_name
	#
	def Employee.find_by_name(l_name, f_name)
	  data = []
		if !l_name.nil? && !f_name.nil?
	    esc_last_name = Employee.mysql.escape_string(l_name.to_s) # Saftey First :)
	    esc_first_name = Employee.mysql.escape_string(f_name.to_s) 		
		  find_query = FIND_EMPLOYEES + " WHERE last_name LIKE '%#{esc_last_name}%'"
		  find_query = find_query + " AND first_name LIKE '%#{esc_first_name}%'"
		elsif !f_name.nil?
	    esc_first_name = Employee.mysql.escape_string(f_name.to_s) # Saftey First :)		
		  find_query = FIND_EMPLOYEES + " WHERE first_name LIKE '%#{esc_first_name}%'"
    elsif !l_name.nil?
	    esc_last_name = Employee.mysql.escape_string(l_name.to_s) # Saftey First :)		
		  find_query = FIND_EMPLOYEES + " WHERE last_name LIKE '%#{esc_last_name}%'"
    end		
		if find_query
  		res = Employee.mysql.query(find_query) 
	  	puts find_query #DEBUG
      res.each_hash do |h|
	      data << Employee.new(h)
      end
		end
		data
	end
	
	# Querys for employees based on the first_name and last_name
	#
	def Employee.find_by_id(id)
	  data = nil
		if !id.nil?
	    esc_id = Employee.mysql.escape_string(id.to_s) # Saftey First :)
		  find_query = FIND_EMPLOYEES + " WHERE id = #{esc_id}"
  		res = Employee.mysql.query(find_query) 
	  	puts find_query #DEBUG
      res.each_hash do |h|
	      data = Employee.new(h)
      end
		end
		data
	end

end
