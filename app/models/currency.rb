class Currency < ActiveRecord::Base
  attr_accessible :abbreviation, :name, :ratio
end
