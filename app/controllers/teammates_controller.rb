class TeammatesController < ApplicationController
	before_filter :authorize

	def index
		@teammate = Teammate.new
		#Render all People that belong to a specific coach(account)
		@teammates = current_user.teammates
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

	def destroy
		@teammate = Teammate.find(params[:id])
    if @teammate.destroy
      flash[:notice] = "Teammate has been deleted"
    else
      flash[:alert] = "Teammate was not deleted"
    end
    redirect_to teammates_path

	end

	def import
		if params[:file] != nil
			file = params[:file].tempfile
			if params[:file].original_filename.end_with?('.csv')
				if current_user.add_players_from_file(file) != false
					flash[:notice] = "CSV uploaded, and teammates added!"
				else
					flash[:alert] = "Sorry invalid headers!"
				end
			else
				flash[:alert] = "Sorry invalid file type!"
			end
		else
			flash[:alert] = "Please attach a valid file"
		end
		redirect_to teammates_path
	end

	private

	def teammates_params
		params.require(:teammate).permit(person: [:name, :email])
	end
end
