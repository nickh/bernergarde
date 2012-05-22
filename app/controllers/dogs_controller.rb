class DogsController < DatabaseController
  def index
  end

  def search
    return redirect_to dogs_path unless params[:bg_id].present? || params[:dog].present?

    @dogs = params[:bg_id].present?? Dog.where(:id => params[:bg_id]) : Dog.matching_any(params[:dog])
    if @dogs.empty?
      flash[:error] = t('db.search.dogs.no_results')
      redirect_to dogs_path
    elsif @dogs.size == 1
      redirect_to @dogs.first
    end
  end

  def show
    begin
      @dog = Dog.find(params[:id])
      respond_to do |format|
        format.html
        format.json { render :json => @dog }
      end
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.html { redirect_to :action => :index }
      end
    end
  end
end
