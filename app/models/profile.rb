# == Schema Information
#
# Table name: profiles
#
#  id             :integer          not null, primary key
#  show_email     :boolean          default(FALSE), not null
#  birthday       :date
#  country        :string(255)
#  gender         :integer
#  about          :text
#  signature      :text
#  contacts_phone :string(255)
#  contacts_skype :string(255)
#  contacts_other :string(255)
#  contacts_url   :string(255)
#  time_zone      :string(255)
#  dispatch       :boolean          default(FALSE), not null
#  avatar         :string(255)
#  user_id        :integer
#

class Profile < ActiveRecord::Base
  attr_accessible :show_email, :birthday, :country, :gender, :about, :signature, :contacts_url, :contacts_other, :contacts_skype, :contacts_phone, :time_zone, :dispatch, :avatar
  
  mount_uploader :avatar, AvatarUploader
  
  belongs_to :user
end
