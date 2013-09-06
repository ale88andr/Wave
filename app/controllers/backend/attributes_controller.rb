class Backend::AttributesController < Backend::ApplicationController
	def new
		@attribute = Attribute.new
	end

	def index
		
	end

	def create
		@attribute = Attribute.new(params[:attribute])
		if @attribute.save
			redirect_to backend_attributes_path, notice: "Аттрибут #{@attribute.name} созданн!"
		else
			flash[:error] = 'Не удалось создать аттрибут!'
			render :new
		end
	end

	def update
		@attribute = Attribute.find(params[:id])
		if @attribute.update_attributes(params[:attribute])
			redirect_to backend_attributes_path, notice: "Аттрибут #{@attribute.name} обновлен!"
		else
			flash[:error] = 'Не удалось обновить аттрибут!'
			render :edit
		end
	end
end