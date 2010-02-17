class Profile < ActiveRecord::Base
  has_many :categories, :order => 'position'
  has_many :items
  has_many :quotes, :conditions => 'sent_at IS NOT NULL', :order => 'created_at DESC'
  validates_presence_of :domain, :name, :html, :from, :subject
  validates_uniqueness_of :domain
end
