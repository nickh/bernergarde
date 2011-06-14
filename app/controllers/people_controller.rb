class PeopleController < DatabaseController
  def index
  end

  def search
    return redirect_to people_path unless params[:bg_id].present? || params[:person].present?

    @people = params[:bg_id].present?? Person.where(:id => params[:bg_id]) : Person.matching_any(params[:person])
    if @people.empty?
      flash[:error] = t('db.search.people.no_results')
      redirect_to people_path
    elsif @people.size == 1
      redirect_to @people.first
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
