#
#  ApplicationController.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/11/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#

require 'osx/cocoa'

class ApplicationController < OSX::NSObject
  ib_outlets :customers_box

  ib_action :sales_returns
  def sales_returns
    @customers_box.setHidden_(true)
  end
  
  ib_action :catalog
  def catalog
    @customers_box.setHidden_(true)
  end
  
  ib_action :close_register
  def close_register
    @customers_box.setHidden_(true)
  end
 
  # Recieves notification when window closes 
  # and terminates the application.
  def windowWillClose(notification)
    OSX::NSApp.terminate(self)
  end
end
