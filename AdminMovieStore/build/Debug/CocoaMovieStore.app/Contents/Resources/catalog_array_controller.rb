#
#  catalog_array_controller.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/16/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#

require 'osx/cocoa'

class CatalogArrayController < OSX::NSArrayController  
  ib_outlets :catalog_box, :table

  def awakeFromNib
    super_awakeFromNib
    columns = @table.tableColumns()
	puts columns[0].dataCellForRow_(0).setStringValue_("Will")
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
