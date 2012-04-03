class PeopleController < ApplicationController
  def people
    @people = Person.where(:approved => true).all
  end

  def person
    @person = Person.where(:approved => true, :id => params[:id])
    if @person.empty?
      flash[:alert] = "Person does not exist!"
      redirect_to people_path
    end
  end
end
