# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
customers = Customer.create([
  {:first_name => 'Will', :last_name => 'Mernagh', :street_1 => '190 Summer', :street_2 => '#405', :city => 'Malden', :zip => '02148', :email => 'will@gmail.com', :phone => '617-519-0352'},
  {:first_name => 'Orla', :last_name => 'Mernagh', :street_1 => '190 Summer', :street_2 => '#405', :city => 'Malden', :zip => '02148', :email => 'orla@gmail.com', :phone => '617-519-0353'},
  {:first_name => 'Bridget', :last_name => 'Connolly', :street_1 => '10 Day', :street_2 => 'Unit 2', :city => 'Medford', :zip => '02148', :email => 'bridget@gmail.com', :phone => '617-519-0354'},
  {:first_name => 'Éanna', :last_name => 'Mernagh', :street_1 => '90 Main', :street_2 => 'Apt 5', :city => 'Medford', :zip => '02148', :email => 'eanna@gmail.com', :phone => '617-519-0355'}
])
employees = Employee.create([
  {:first_name => 'Jim', :last_name => 'Dalton', :password => 'letmein', :position => 'associate'},
  {:first_name => 'Sarah', :last_name => 'Dunn', :password => 'letmein', :position => 'associate'},
  {:first_name => 'Peter', :last_name => 'Young', :password => 'letmein', :position => 'associate'},
  {:first_name => 'Paul', :last_name => 'Daly', :password => 'letmein', :position => 'owner'}
])
sections = Section.create([
    {:name => 'New Releases', :location => 'C01'},
    {:name => 'Comedy', :location => 'C02'},
    {:name => 'Award Winners', :location => 'C03'},
    {:name => 'Action', :location => 'C04'}
])
items = Item.create([
  {:title => '(500) Days of Summer', :year => '2009-01-01', :genre => 'Romance', :item_type => 'Movie'},
  {:title => 'Where the Wild Things Are', :year => '2009-01-01', :genre => 'Family', :item_type => 'Movie'},
  {:title => 'Couples Retreat', :year => '2009-01-01', :genre => 'Comedy', :item_type => 'Movie'},
  {:title => 'Transformers', :year => '2007-01-01', :genre => 'Action', :item_type => 'Movie'}
])
copies = Copy.create([
  {:item_id => 1, :copy_type => 'BlueRay', :sale_price => 9.99, :wholesale_price => '4.00', :section_id => 1},
  {:item_id => 2, :copy_type => 'DVD', :sale_price => 9.99, :wholesale_price => '4.00', :section_id => 1},
  {:item_id => 3, :copy_type => 'BlueRay', :sale_price => 9.99, :wholesale_price => '4.00', :section_id => 2},
  {:item_id => 4, :copy_type => 'DVD', :sale_price => 9.99, :wholesale_price => '4.00', :section_id => 4},
  {:item_id => 1, :copy_type => 'BlueRay', :sale_price => 9.99, :wholesale_price => '4.00', :section_id => 1},
  {:item_id => 2, :copy_type => 'DVD', :sale_price => 9.99, :wholesale_price => '4.00', :section_id => 1},
  {:item_id => 3, :copy_type => 'BlueRay', :sale_price => 9.99, :wholesale_price => '4.00', :section_id => 2},
  {:item_id => 4, :copy_type => 'DVD', :sale_price => 9.99, :wholesale_price => '4.00', :section_id => 4},
  {:item_id => 1, :copy_type => 'BlueRay', :sale_price => 9.99, :wholesale_price => '4.00', :section_id => 1},
  {:item_id => 2, :copy_type => 'DVD', :sale_price => 9.99, :wholesale_price => '4.00', :section_id => 1},
  {:item_id => 3, :copy_type => 'BlueRay', :sale_price => 9.99, :wholesale_price => '4.00', :section_id => 2},
  {:item_id => 4, :copy_type => 'DVD', :sale_price => 9.99, :wholesale_price => '4.00', :section_id => 4},
  {:item_id => 1, :copy_type => 'BlueRay', :sale_price => 9.99, :wholesale_price => '4.00', :section_id => 1},
  {:item_id => 2, :copy_type => 'DVD', :sale_price => 9.99, :wholesale_price => '4.00', :section_id => 1},
  {:item_id => 3, :copy_type => 'BlueRay', :sale_price => 9.99, :wholesale_price => '4.00', :section_id => 2},
  {:item_id => 4, :copy_type => 'DVD', :sale_price => 9.99, :wholesale_price => '4.00', :section_id => 4}
])
sales = Sale.create([
  {:copy_id => 1, :customer_id => 1, :employee_id => 1, :transaction_date => Time.now, :transaction_type => 'sale', :transaction_ammount => 9.99},
  {:copy_id => 3, :customer_id => 2, :employee_id => 2, :transaction_date => Time.now, :transaction_type => 'sale', :transaction_ammount => 9.99},
  {:copy_id => 4, :customer_id => 3, :employee_id => 3, :transaction_date => Time.now, :transaction_type => 'sale', :transaction_ammount => 9.99},
  {:copy_id => 7, :customer_id => 4, :employee_id => 4, :transaction_date => Time.now, :transaction_type => 'sale', :transaction_ammount => 9.99}
])
studios = Studio.create([
  {:name => 'Fox Searchlight', :category => 'Hollywood'},
  {:name => 'Warner Bros.', :category => 'Hollywood'},
  {:name => 'Universal Pictures', :category => 'Hollywood'},
  {:name => 'DreamWorks SKG', :category => 'Hollywood'},
  {:name => 'Canal+', :category => 'Foreign'},
  {:name => 'IFC', :category => 'independant'}  
])
s = Studio.find(1)
a = Item.find(1)
b = Item.find(2)
c = Item.find(3)
d = Item.find(4)
s.items << a
s.items << b
s.items << c
s.items << d
s.save

celebrities = Celebrity.create([
  {:first_name => 'Michael', :last_name => 'Bay', :dob => '1965-02-19', :position => '1010'},
  {:first_name => 'Peter', :last_name => 'Billingsley', :dob => '1971-04-16', :position => '1000'},
  {:first_name => 'Spike', :last_name => 'Jonze', :dob => '1969-10-22', :position => '1000'},
  {:first_name => 'Mark', :last_name => 'Webb', :position => '1000'},
  {:first_name => 'Zooey', :last_name => 'Deschanel', :position => '0100'},
  {:first_name => 'Shia', :last_name => 'LaBeouf', :position => '0100'},
  {:first_name => 'Jason', :last_name => 'Bateman', :position => '0100'},
  {:first_name => 'Max', :last_name => 'Records', :position => '0100'},
  {:first_name => 'John', :last_name => 'Isbell', :position => '0010'},
  {:first_name => 'Kenny', :last_name => 'Bates', :position => '0010'},
  {:first_name => 'John', :last_name => 'Doe', :position => '0010'},
  {:first_name => 'Jane', :last_name => 'Doe', :position => '0010'}
])
a.celebrities << Celebrity.find(1)
b.celebrities << Celebrity.find(2)
c.celebrities << Celebrity.find(3)
d.celebrities << Celebrity.find(4)
d.celebrities << Celebrity.find(5)
c.celebrities << Celebrity.find(6)
b.celebrities << Celebrity.find(7)
a.celebrities << Celebrity.find(8)
a.celebrities << Celebrity.find(9)
b.celebrities << Celebrity.find(10)
c.celebrities << Celebrity.find(11)
d.celebrities << Celebrity.find(12)
a.save
b.save
c.save
d.save
