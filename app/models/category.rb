class Category < ActiveRecord::Base
  has_many :items, -> { order :position }
  acts_as_list scope: :profile

  validates :name, presence: true
end
