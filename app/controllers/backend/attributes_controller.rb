class Backend::AttributesController < Backend::ApplicationController

	before_filter only:[:edit, :update, :destroy] { |m| m.get_attribute_by_id(params[:id]) }

	def new
		@attribute = Attribute.new
	end

	def index
		@attributes = Attribute.all
	end

	def create
		@attribute = Attribute.new(params[:attribute])
		if @attribute.save
			redirect_to backend_attributes_path, notice: "Аттрибут '#{@attribute.name}' созданн!"
		else
			flash[:error] = 'Не удалось создать аттрибут!'
			render :new
		end
	end

	def update
		if @attribute.update_attributes(params[:attribute])
			redirect_to backend_attributes_path, notice: "Аттрибут '#{@attribute.name}' обновлен!"
		else
			flash[:error] = 'Не удалось обновить аттрибут!'
			render :edit
		end
	end

	def destroy
		@attribute.destroy
		redirect_to backend_attributes_path
	end

	protected

		def get_attribute_by_id id
			@attribute = Attribute.find(id)
		end
end