# == Schema Information
#
# Table name: currencies
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  abbreviation :string(255)
#  ratio        :float
#

class Currency < ActiveRecord::Base
  attr_accessible :abbreviation, :name, :ratio
end
