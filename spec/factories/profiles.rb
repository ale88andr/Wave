# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
  	show_email			true
  	birthday				'01-01-2013'
  	country					'UA'
  	gender					'1'
  	about						'any text'
  	signature				'any text'
  	contacts_url		'http://any.url/'
  	contacts_other	'any contact'
  	contacts_skype	'skype'
  	contacts_phone	'phone number'
  	time_zone				''
  	dispatch				false
  	avatar					'path/to/avatar'
  end
end
