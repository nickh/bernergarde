class PagesController < ApplicationController
  def show
    page = params[:id] || 'home'
    render :action => page
  end
end
