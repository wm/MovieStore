class Sale < ActiveRecord::Base
  belongs_to :employee
  belongs_to :customer
  belongs_to :copy
  belongs_to :item
end
