#
#  app_delegate.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/24/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#
# This is the delegate specified in the view for when the preferences menu item is clicked on.
require 'osx/cocoa'

class AppDelegate < OSX::NSObject
   
  # This is the action connected to the preferences menu item.
  #
  ib_action :change_preferences
  def change_preferences(sender) 
	  unless @wc
      @wc = OSX::NSWindowController.alloc.initWithWindowNibName("Preferences")
    end 
		@wc.showWindow(self) 
		@wc.window.makeKeyWindow
	  puts "Will launch preference panel"
	end
end
