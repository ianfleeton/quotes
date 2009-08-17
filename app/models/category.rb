class Category < ActiveRecord::Base
  has_many :items, :order => :position
  acts_as_list :scope => :profile
  attr_protected :profile_id
end
