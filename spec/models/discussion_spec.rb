# == Schema Information
#
# Table name: discussions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  entity_id  :integer
#  comment    :text
#  positive   :text
#  negative   :text
#  answer     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Discussion do
  pending "add some examples to (or delete) #{__FILE__}"
end
