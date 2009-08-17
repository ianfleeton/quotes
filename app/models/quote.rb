class Quote < ActiveRecord::Base
  belongs_to :profile
  attr_protected :profile_id
end
