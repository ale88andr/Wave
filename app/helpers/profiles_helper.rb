module ProfilesHelper
	def show_email email, sign
		sign ? email : "Пользователь предпочёл скрыть эти данные"
	end

	def gender param
		param == 1 ? "Мужской" : "Женский"
	end

	def format_profile_date date
		date.to_formatted_s(:profile_datetime)
	end

	def rescue_empty_field field
		field == '' || field.nil? ? "Не указанно" : field
	end
end
