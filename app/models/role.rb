class Role < ActiveRecord::Base
  attr_accessible :name

  # CanCan permission.
  has_and_belongs_to_many :users
end