#
#  CatalogController.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/14/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#

require 'osx/cocoa'

# This is the controller for the catalog box
#
class CatalogController < ApplicationController
  
  attr_accessor :items, :copies, :customers
	attr_accessor :title, :genre, :year, :directors, :actors, :item_id
	ib_outlets :title, :genre, :year, :directors, :actors, :item_id
  ib_outlets :catalog_box, :items_table, :copies_table, :status_label, :customers_sales_table

  # Called upon instantiation.
	# Finds all items in order to populate the catalog table.
	#
  def initialize()
	  begin
	    @items = Item.find_with_conditions(nil)
		rescue Exception => e
		  model_exception(e,@status_label)
		end
		@copies = nil
		@customers = nil
  end
  
	# A search function with link to the view.
	# ib_action is used by InterfaceBuilder to tell the view that this function can be used.
	#
  ib_action :search
  def search
	  begin
			@items = Item.find_with_conditions(gen_conditions)
			@items_table.reloadData
		rescue Exception => e
		  model_exception(e,@status_label)
		end
  end
	
	# This method needs to be implemented by the dataSource of an NSTableView.
	# It is called when an item is selected/deselected
	#
	# This view uses this controller as its dataSource for items and copies.
	# We check for items only here since nothing happens when a copy is selected 
	# only and item.
	#
	def tableViewSelectionDidChange(notification)
		if notification.object == @items_table
			if @items_table.selectedRow < 0
				@copies = nil
				@customers = nil
			else
				item_id = @items[@items_table.selectedRow].id
				@copies = Copy.find_by_item_id(item_id) 
				@customers = Customer.find_by_item_id(item_id)
			end
			@copies_table.reloadData
			@customers_sales_table.reloadData
		end
	end
	
	# This method needs to be implemented by the dataSource of an NSTableView.
	# This function is used by the NSTableView to populate itself
  # It is used for the customer_table, items_table, and the copies_table
	#
  def tableView_objectValueForTableColumn_row_(view, col, row)
    if view == @items_table
			case col.identifier.to_s
			when "TITLE"
				return @items[row].title.to_s
			when "YEAR"
				return @items[row].year.split('-')[0].to_s
			when "GENRE"
				return @items[row].genre.to_s
			else
				return nil
			end
  	elsif view == @copies_table
			case col.identifier.to_s	
			when "SECTION"
				return @copies[row].section_name
			when "COPY_TYPE"
				return @copies[row].copy_type
			when "PRICE"
				return @copies[row].sale_price
			else
				return nil
			end
		elsif view == @customers_sales_table
			case col.identifier.to_s
			when "ID"
				return @customers[row].id
			when "FNAME"
				return "* " + @customers[row].first_name if @customers[row].transaction_type == "return"
				return @customers[row].first_name if @customers[row].transaction_type != "return"				
			when "LNAME"
				return @customers[row].last_name
			when "STREET1"
				return @customers[row].street_1
			when "CITY"
				return @customers[row].city
			when "ZIP"
				return @customers[row].zip
			when "EMAIL"
				return @customers[row].email
			else
				return nil
			end
		end
  end
  
	# This method needs to be implemented by the dataSource of an NSTableView.
	#
  def numberOfRowsInTableView_(view)
  	if view == @copies_table
      return 0 if @copies.nil?
      return @copies.length
    elsif view == @items_table
	    return 0 if @items.nil?
	    return @items.length
		elsif view == @customers_sales_table
	    return 0 if @customers.nil?
	    return @customers.length
	  end
  end
	
	# Hides all boxes in the view and then make the catalog_box visible
	# note that hide_boxes is inherited from ApplicationController
	#
  ib_action :reset_catalog_box
  def reset_catalog_box
	  hide_boxes
    @catalog_box.setHidden_(false)
  end
  
	# Hides the catalog_box
  def hide_catalog_box
    @catalog_box.setHidden_(true)
  end
	
	private
	
	def id
	  @item_id
	end
	
	# Converts the search attributes into an array only containing those that have 
	# non-blank values. The attributes are set by the view.
	#
	def gen_conditions
	  conditions = {}
		search_fields = [:title, :genre, :year, :id]
		search_fields.each do |sf|
		  conditions[sf] = self.send(sf).stringValue unless self.send(sf).nil? || self.send(sf).stringValue == ""
		end
		(conditions.empty?) ? nil : conditions
	end

end
