#!/usr/bin/ruby
#  sales_controller.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/22/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#
require 'osx/cocoa'

class ItemsController < ApplicationController
  attr_accessor :items,:copies
	ib_outlets :add_remove_items_box
  ib_outlets :items_table,:copies_table
	ib_outlets :title,:year,:genre,:id
	attr_accessor :title, :genre, :year,:id, :copy_type, :section_name, :sale_price, :wholesale_price
	ib_outlets :copy_type, :section_name, :sale_price, :wholesale_price
	ib_outlets :item_add_button,:item_edit_button,:item_del_button
	ib_outlets :copy_add_button,:copy_edit_button,:copy_del_button
	ib_outlets :info_box,:copy_info_box
	
	# Called upon instantiation.
	# Finds all items in order to populate the catalog table.
	#
  def initialize()
		@items = nil
		@copies = nil
  end
	
	# A search function with link to the view.
	# ib_action is used by InterfaceBuilder to tell the view that this function can be used.
	#
  ib_action :search
  def search
	  @info_box.setStringValue("")
	  begin
			@items = Item.find_with_conditions(gen_conditions)
			if @items.nil? || @items.length < 1
			  @item_add_button.setEnabled_(true)
			else
			  @item_add_button.setEnabled_(false)
			end
			@items_table.reloadData
		rescue Exception => e
		  model_exception(e,@status_label)
		end
  end
	
	# A search function with link to the view.
	# ib_action is used by InterfaceBuilder to tell the view that this function can be used.
	#
  ib_action :clear
  def clear
	  @info_box.setStringValue("")
		@copy_info_box.setStringValue("")
	  @title.setStringValue("")
		@genre.setStringValue("")
		@year.setStringValue("")
		@id.setStringValue("")
  end
	
	ib_action :delete_item
	def delete_item
		if @copies.nil? || @copies.length < 1
		  item = @items[@items_table.selectedRow]
			begin
  			item.delete
				search
			rescue Exception => e
			  model_exception e,@status_label
		  end
		else
		  @info_box.setStringValue("You cannot delete an Item with copies.")
		end
	end
	
	ib_action :delete_copy
	def delete_copy
	  copy = @copies[@copies_table.selectedRow]
		begin
  		copy.delete
			item_id = @items[@items_table.selectedRow].id
			@copies = Copy.find_by_item_id(item_id)
			@copies_table.reloadData
		rescue Exception => e
			model_exception e,@status_label
		end
	end
	
	
	ib_action :add_new_item
	def add_new_item
	  if @title.stringValue.empty? || @year.stringValue.empty? || @genre.stringValue.empty?
		  @info_box.setStringValue("All 3 fields need to be filled to create a new Item")
	  else
		  @info_box.setStringValue("")
		  item = Item.new(:item_type => "movie", :title => @title.stringValue, :year => @year.stringValue, :genre => @genre.stringValue)
			begin
			  item.create_new_item
				search
			rescue Exception => e
			  model_exception e,@status_label
	    end
		end
	end
	
	ib_action :update_selected_item
	def update_selected_item
	  puts "here"
	  if @title.stringValue.empty? || @year.stringValue.empty? || @genre.stringValue.empty?
		  @info_box.setStringValue("All 3 fields need to be filled to create a new Item")
	  else
		  @info_box.setStringValue("")
			item = @items[@items_table.selectedRow]
			item.title = @title.stringValue
			item.year = @year.stringValue
			item.genre = @genre.stringValue
			begin
			  item.update
				search
			rescue Exception => e
			  model_exception e,@status_label
	    end
		end
	end
	
	ib_action :add_new_copy
	def add_new_copy
	  if @copy_type.stringValue.empty? || @section_name.stringValue.empty? || @wholesale_price.stringValue.empty?|| @sale_price.stringValue.empty?
		  @copy_info_box.setStringValue("All 4 fields need to be filled to create a new Copy")
	  else
		  @copy_info_box.setStringValue("")
		  copy = Copy.new(:item_id => @items[@items_table.selectedRow].id, :copy_type => @copy_type.stringValue, :section_name => @section_name.stringValue, :wholesale_price => @wholesale_price.stringValue, :sale_price => @sale_price.stringValue)
			begin
			  copy.create_new_copy
				item_id = @items[@items_table.selectedRow].id
				@copies = Copy.find_by_item_id(item_id)
				@copies_table.reloadData
			rescue Exception => e
			  model_exception e,@status_label
	    end
		end
	end
	
	ib_action :update_selected_copy
	def update_selected_copy
	  puts "here"
	  if @copy_type.stringValue.empty? || @section_name.stringValue.empty? || @wholesale_price.stringValue.empty?|| @sale_price.stringValue.empty?
		  @copy_info_box.setStringValue("All 4 fields need to be filled to update the selected Copy")
	  else
		  @info_box.setStringValue("")
			copy = @copies[@copies_table.selectedRow]
			copy.wholesale_price = @wholesale_price.stringValue
			copy.sale_price = @sale_price.stringValue
			copy.section_name = @section_name.stringValue
			copy.copy_type = @copy_type.stringValue			
			begin
			  copy.update
				item_id = @items[@items_table.selectedRow].id
				@copies = Copy.find_by_item_id(item_id)
				@copies_table.reloadData
			rescue Exception => e
			  model_exception e,@status_label
	    end
		end
	end
	  
	
	# This method needs to be implemented by the dataSource of an NSTableView.
	# This controller to the TableView as its dataSource.
	#
	def tableViewSelectionDidChange(notification)
		if notification.object == @items_table
			@copy_info_box.setStringValue("")
			@info_box.setStringValue("")
		  @copies_table.deselectAll_ nil
			if @items_table.selectedRow < 0
				@copies = nil
				@customers = nil
				@item_add_button.setEnabled_(false)
				@item_edit_button.setEnabled_(false)
				@item_del_button.setEnabled_(false)
   	    @copy_add_button.setEnabled_(false)
			else
				item_id = @items[@items_table.selectedRow].id
				@copies = Copy.find_by_item_id(item_id) 
				@item_add_button.setEnabled_(false)
				@item_edit_button.setEnabled_(true)
				@item_del_button.setEnabled_(true)
   	    @copy_add_button.setEnabled_(true)
				
				# Set the fields to the values of the selected row
				@title.setStringValue(@items[@items_table.selectedRow].title)
				@year.setStringValue(@items[@items_table.selectedRow].year)
				@genre.setStringValue(@items[@items_table.selectedRow].genre)				
			end
			@copies_table.reloadData
		elsif notification.object == @copies_table
		  if @copies_table.selectedRow < 0			  
   	    @copy_add_button.setEnabled_(true)
				@copy_edit_button.setEnabled_(false)
				@copy_del_button.setEnabled_(false)
			else
   	    @copy_add_button.setEnabled_(false)
				@copy_edit_button.setEnabled_(true)
				@copy_del_button.setEnabled_(true)
				
				# Set the fields to the values of the selected row
				@copy_type.setStringValue(@copies[@copies_table.selectedRow].copy_type)
				@section_name.setStringValue(@copies[@copies_table.selectedRow].section_name)
				@wholesale_price.setStringValue(@copies[@copies_table.selectedRow].wholesale_price)
				@sale_price.setStringValue(@copies[@copies_table.selectedRow].sale_price)												
			end
		end
	end
	
	# This method needs to be implemented by the dataSource of an NSTableView.
	# This function is used by the NSTableView to populate itself
  # It is used for both the items_table and the copies_table
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
			when "SPRICE"
				return @copies[row].sale_price
			when "WSPRICE"
				return @copies[row].wholesale_price
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
	  end
  end
	
	# Hides all boxes in the view and then make the add_remove_items_box visible
	# note that hide_boxes is inherited from ApplicationController
	#
  ib_action :reset_add_remove_items_box
  def reset_add_remove_items_box
	  hide_boxes
    @add_remove_items_box.setHidden_(false)
  end
  
	# Hides the add_remove_items_box
	#
  def hide_add_remove_items_box
    @add_remove_items_box.setHidden_(true)
  end
	
	private
	
	# Converts the search attributes into an array only containing those that have 
	# non-blank values
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
