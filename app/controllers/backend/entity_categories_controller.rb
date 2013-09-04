class Backend::EntityCategoriesController < Backend::ApplicationController
	def index
		@categories = EntityCategory.all
	end
end