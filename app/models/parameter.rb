class Parameter < ActiveRecord::Base
  belongs_to :attribute
  belongs_to :entity
  attr_accessible :value, :attribute_id, :entity_id
end
