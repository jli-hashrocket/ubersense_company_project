class TeammatesController < ApplicationController
	before_filter :authorize

	def index
		@teammate = Teammate.new
		#Render all People that belong to a specific coach(account)
		@teammates = current_user.people
	end

	def new
		#Open new People Object instance
	end

	def create
		@teammate = Teammate.new
		if @teammate.add_teammate(current_user,teammates_params)
			redirect_to teammates_path
			flash[:notice] = "Teammate Added!"
		else
			redirect_to teammates_path
			flash[:alert] = "Teammate Not Added!"
		end
	end

	def show

	end

	def edit

	end

	def update

	end

	def destroy

	end

	def import
		file = params[:file]
		file.tempfile
	end

	private

	def teammates_params
		params.require(:teammate).permit(person: [:name, :email])
	end
end
