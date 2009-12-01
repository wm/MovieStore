#
#  app_delegate.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/24/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#

require 'osx/cocoa'

class AppDelegate < OSX::NSObject

  ib_action :change_preferences
  def change_preferences(sender) 
	  unless @wc
      @wc = OSX::NSWindowController.alloc.initWithWindowNibName("Preferences")
    end 
		@wc.showWindow(self) 
		@wc.window.makeKeyWindow
	end
end
