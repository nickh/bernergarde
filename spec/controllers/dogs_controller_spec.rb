require 'spec_helper'

describe DogsController do
  before(:all) do
    call_names = %w(Malfoy Manfrendinjinsen Maverick)
    @dogs = call_names.collect do |call_name|
      Factory(:dog, :call_name => call_name)
    end
  end

  describe '#index' do
    it 'displays the index page' do
      get :index, :locale => I18n.locale
      response.should be_success
      response.should render_template 'index'
    end
  end

  describe '#search' do
    context 'with no search params' do
      it 'redirects to the index page' do
        post :search, :locale => I18n.locale
        response.should redirect_to dogs_path
      end
    end

    context 'with a valid BG Dog ID' do
      it 'redirects to the dog page' do
        valid_dog = @dogs.first
        post :search, :locale => I18n.locale, :bg_id => valid_dog.id
        response.should redirect_to valid_dog
      end
    end

    context 'with an invalid BG Dog ID' do
      before(:all) do
        @missing_dog = Factory(:dog)
        @missing_dog.destroy
      end

      it 'redirects to the index page' do
        post :search, :locale => I18n.locale, :bg_id => @missing_dog.id
        response.should redirect_to dogs_path
      end

      it 'sets a flash error' do
        post :search, :locale => I18n.locale, :bg_id => @missing_dog.id
        flash[:error].should_not be_nil
      end
    end

    context 'with search params' do
      context 'and 1 search result' do
        before(:each) do
          @result = @dogs.first
          Dog.should_receive(:matching_any).and_return([@result])
        end

        it 'redirects to the matching dog page' do
          post :search, :locale => I18n.locale, :dog => {:call_name => 'foo'}
          response.should redirect_to @result
        end
      end

      context 'and != 1 search result' do
        before(:each) do
          Dog.should_receive(:matching_any).and_return(@dogs)
        end

        it 'displays the search results' do
          post :search, :locale => I18n.locale, :dog => {:call_name => 'foo'}
          response.should be_success
          response.should render_template 'search'
        end
      end
    end
  end

  describe '#show' do
    context 'with an invalid dog id' do
      it 'redirects to the index page' do
        missing_dog = Factory(:dog)
        missing_dog.destroy
        get :show, :locale => I18n.locale, :id => missing_dog.id
        response.should redirect_to dogs_path
      end
    end

    context 'with a valid dog id' do
      it 'loads the specified dog' do
        valid_dog = @dogs.first
        get :show, :locale => I18n.locale, :id => valid_dog.id
        assigns[:dog].should == valid_dog
      end

      it 'displays the person info' do
        valid_dog = @dogs.first
        get :show, :locale => I18n.locale, :id => valid_dog.id
        response.should render_template 'show'
      end
    end
  end
end
