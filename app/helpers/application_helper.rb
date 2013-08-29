module ApplicationHelper

  APPLICATION_NAME = Rails.application.class.parent

	def resource_name
	  :user
	end

	def resource
	  @resource ||= User.new
	end

	def devise_mapping
	  @devise_mapping ||= Devise.mappings[:user]
	end

  def set_title page_title = nil
    page_title == '' ? APPLICATION_NAME : "#{APPLICATION_NAME} :.: #{page_title}"
  end
end