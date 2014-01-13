class PeopleController < ApplicationController
# 	before_filter :authorize

# 	def index
# 		@person = Person.new
# 		@teammates = current_user.people
# 	end

# 	def create
# 		@person = Person.new(people_params)
# 		if @person.teammate(current_user)
# 			redirect_to people_path
# 			flash[:notice] = "Teammate Added!"
# 		else
# 			redirect_to people_path
# 			flash[:notice] = "Teammate Not Added!"
# 		end
# 	end

# 	def destroy

# 	end

# 	private

# 	def people_params
# 		params.require(:person).permit(:name, :email)
# 	end
end
