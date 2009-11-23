#
#  DataBaseModel.rb
#  CocoaMovieStore
#
#  Created by Will Mernagh on 11/22/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#
require '/opt/local/mysql-ruby/mysql-ruby-2.8.1/mysql.o'

class DataBaseModel

	protected
	
	# The MySQL query connection
	#
  def DataBaseModel.mysql
    if @m.nil?
      @m = Mysql.connect('localhost', 'wmernagh', 'water7932', 'movie_store')
    end
    @m	
  end
end
