#
#  catalog_array_controller.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/16/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#

require 'osx/cocoa'

class CatalogArrayController < OSX::NSArrayController  

  attr_accessor :data
  ib_outlets :catalog_box, :table

  def initialize()
    @data = []
  end
  
  ib_action :reset_catalog_box
  def reset_catalog_box
	#ApplicationController.hide_boxes
    @catalog_box.setHidden_(false)
  end
  
  def hide_catalog_box
    @catalog_box.setHidden_(true)
  end
  
end
