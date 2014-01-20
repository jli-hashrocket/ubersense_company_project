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
		if Teammate.add_teammate(current_user,teammates_params)
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
		file = params[:file].tempfile
		if params[:file].original_filename.split('.')[1] == 'csv'
			if Account.add_players_from_file(current_user, file) != false
				flash[:notice] = "CSV uploaded, and teammates added!"
				redirect_to teammates_path
			else
				flash[:alert] = "Sorry invalid headers!"
				redirect_to teammates_path
			end
		else
			flash[:alert] = "Sorry invalid file type!"
			redirect_to teammates_path
		end
	end

	private

	def teammates_params
		params.require(:teammate).permit(person: [:name, :email])
	end
end
