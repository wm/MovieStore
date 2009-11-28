#
#  DataBaseModel.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/22/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#
require '/opt/local/mysql-ruby/mysql-ruby-2.8.1/mysql.o'
require 'osx/cocoa'

class DataBaseModel

	protected
	
	# The MySQL query connection
	#
  def DataBaseModel.mysql
	  mysql_prefs = [{ :property => "Host", :value => "localhost"}, 
								  { :property => "User", :value => "wmernagh"}, 
								  { :property => "Password", :value => "water7932"},
								  { :property => "Database", :value => "movie_store"},
								  { :property => "TestProp", :value => "this is a test"}
							   ]
		@defaults = OSX::NSUserDefaults.standardUserDefaults
		@defaults.registerDefaults(:mysql_properties => mysql_prefs)
		
    if @m.nil?
		  mysql_prefs = @defaults.objectForKey(:mysql_properties)
      @m = Mysql.connect(
			  mysql_prefs[0][:value], 
				mysql_prefs[1][:value], 
				mysql_prefs[2][:value], 
				mysql_prefs[3][:value]
			)
    end
    @m	
  end
	
end
