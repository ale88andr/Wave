class Manufacturer < ActiveRecord::Base
  attr_accessible :description, :image, :name, :url
  mount_uploader :image, LogoUploader

  VALID_URL_FORMAT = /[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:+#]*[\w\-\@?^=%&amp;+#])?/i

  validates :name, presence: { message: 'Это поле должно быть заполненно' }, uniqueness: { message: 'Производитель с таким названием уже существует!' }
  validates :url, format: { with: VALID_URL_FORMAT, message: 'Неверный формат URL адреса' }, allow_blank: true

  default_scope order("name ASC")
end