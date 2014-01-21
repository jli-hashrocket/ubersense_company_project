class PeopleController < ApplicationController

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])
    if @person.account.nil?
      if @person.update_attributes(people_params)
        flash[:notice] = "Person has been updated"
        redirect_to teammates_path
      else
        flash[:alert] = "Person not updated"
        render 'edit'
      end
    else
      raise ApplicationController::RoutingError.new('Not Found')
    end

  end

  private

  def people_params
    params.require(:person).permit(:name, :email)
  end

end
