#
#  CatalogController.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/14/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#

require 'osx/cocoa'

class CatalogController < ApplicationController
  ib_outlets :catalog_box
  
  ib_action :reset_catalog_box
  def reset_catalog_box
	hide_boxes
    @catalog_box.setHidden_(false)
  end
  
  def hide_catalog_box
    @catalog_box.setHidden_(true)
  end

end
