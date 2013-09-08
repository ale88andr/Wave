class Manufacturer < ActiveRecord::Base
  attr_accessible :description, :image, :name, :url
  mount_uploader :image, LogoUploader
end