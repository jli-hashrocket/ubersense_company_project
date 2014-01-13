class TeammatesController < ApplicationController
	before_filter :authorize

	def index
		#Render all People that belong to a specific coach(account)
		#@person = People.all
	end
	
	def new
		#Open new People Object instance
	end

	def create
		#Create new People Object
		#@teammate = Teammate.new
		# if @teammate = Teammate.add_teammate

		# else

		# end
	end

	def show

	end

	def edit

	end

	def update

	end

	def destroy

	end

	private 

	def teammates_params
		params.require(:teammate).permit(people: [:name, :email])
	end
end
