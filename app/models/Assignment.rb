class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  attr_accessible :user_id
  attr_accessible :role_id
end