# == Schema Information
#
# Table name: parameters
#
#  id           :integer          not null, primary key
#  attribute_id :integer
#  entity_id    :integer
#  value        :string(255)
#

class Parameter < ActiveRecord::Base
  belongs_to :attribute
  belongs_to :entity
  attr_accessible :value, :attribute_id, :entity_id
end
