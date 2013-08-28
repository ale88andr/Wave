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

require 'spec_helper'

describe Profile do
  pending "add some examples to (or delete) #{__FILE__}"
end
