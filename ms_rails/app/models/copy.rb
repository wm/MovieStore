class Copy < ActiveRecord::Base
  belongs_to :item
  belongs_to :section
  # a copy can be sold, returned, sold, etc.
  has_many :sales
  has_many :customers, :through => :sales
end
