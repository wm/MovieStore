#
#  ApplicationController.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/11/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#
require 'osx/cocoa'

class ApplicationController < OSX::NSObject
  ib_outlets :customers_box, :catalog_box

  #ib_action :hide_boxes
  def hide_boxes
    @customers_box.setHidden_(true)
	@catalog_box.setHidden_(true)
  end
  
  # Recieves notification when window closes 
  # and terminates the application.
  def windowWillClose(notification)
    OSX::NSApp.terminate(self)
  end
end
