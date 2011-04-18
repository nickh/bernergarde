class PeopleController < ApplicationController
  def index
    if params[:bg_id].blank?
      if params[:person].blank?
        render 'search_form'
      else
        @people = Person.matching_any(params[:person])
        if @people.size == 1
          redirect_to @people.first
        else
          render 'search_results'
        end
      end
    else
      begin
        person = Person.find(params[:bg_id])
        redirect_to person
      rescue ActiveRecord::RecordNotFound
        render 'search_form'
      end
    end
  end

  def show
    begin
      @person = Person.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to :action => :index
    end
  end
end
