class PeopleController < ApplicationController

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])
    if @person.update_attributes(people_params)
      flash[:notice] = "Person has been updated"
    else
      flash[:alert] = "Person not updated"
    end
    redirect_to teammates_path
  end

  private

  def people_params
    params.require(:person).permit(:name, :email)
  end

end
