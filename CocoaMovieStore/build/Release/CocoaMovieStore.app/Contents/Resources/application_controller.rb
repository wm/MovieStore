#
#  ApplicationController.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/11/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#
require 'osx/cocoa'

class ApplicationController < OSX::NSObject
  ib_outlets :customers_box, :catalog_box, :sales_returns_box, :status_label
	ib_outlets :login_box, :login_label, :login_username, :login_password, :button_box

  #ib_action :hide_boxes
  def hide_boxes
	  @sales_returns_box.setHidden_(true)
    @customers_box.setHidden_(true)
	  @catalog_box.setHidden_(true)
		@status_label.setStringValue("")
  end
  
  # Recieves notification when window closes 
  # and terminates the application.
  def windowWillClose(notification)
    OSX::NSApp.terminate(self)
  end
	
	ib_action :login
	def login
	  if !@login_username.stringValue.nil? && !@login_username.stringValue.empty?
		  begin
  		  employee = Employee.find_by_id(@login_username.stringValue.to_i)
				if @login_password.stringValue == employee.password
					@login_box.setHidden_(true)
					@button_box.setHidden_(false)
					$employee_id = employee.id
				else
					@login_label.setStringValue("Invalid credentials")
				end
			rescue Exception => e
			  model_exception e,@status_label
			end
		else
		  @login_label.setStringValue("Invalid credentials")
		end
	end
	
	ib_action :logout
	def logout
	  @customers_box.setHidden_(true)
		@catalog_box.setHidden_(true)
		@sales_returns_box.setHidden_(true)
		
		@login_username.setStringValue("")
		@login_password.setStringValue("")
	  @login_box.setHidden_(false)
		
		@button_box.setHidden_(true)
	end
	
	protected
	
	# Handles exceptions thrown from the Model. These will be most
	# likely MySQL related.
	#
	def model_exception(e, a_label)
	  puts e  #DEBUG - ERRORS
		puts clean_backtrace(e)  #DEBUG - ERRORS
		a_label.setStringValue("Database Error: " + e.to_s) unless a_label.nil?
	end
	
	# Prints the backtrace in a nice way
	#
	def clean_backtrace(exception)
    if backtrace = exception.backtrace
			backtrace.join("\n    ") + "\n\n"
		end
	end
end
