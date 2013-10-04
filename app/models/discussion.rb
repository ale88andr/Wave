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

class Discussion < ActiveRecord::Base

  belongs_to :user
  belongs_to :entity
  attr_accessible :answer, :comment, :negative, :positive

  validates :comment, presence: { message: 'Это поле должно быть заполненно!' }

  protected
  	def self.create_entity_discussion_by_user (author, subject, discuss)
  		discuss = author.discussions.new(discuss) unless author.nil?
  		discuss.entity_id = subject 
  		if discuss.save
  			"Ваш отзыв дабавлен"
  		else
  			"Не удалось добавить отзыв!"
  		end
  	end

end
