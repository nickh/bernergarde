require 'spec_helper'

describe PeopleController do
  before(:all) do
    names = [
      ['Nick',    'Hengeveld'],
      ['Nicholas','Henchman'],
      ['Nicole',  'Hennessey'],
      ['Nicky',   'Henkel'],
      ['Nico',    'Hennino']
    ]
    @berner_people = names.collect do |name|
      Factory(:person, :first_name => name.first, :last_name => name.last)
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
        response.should redirect_to people_path
      end
    end

    context 'with a valid BG People ID' do
      it 'redirects to the person page' do
        valid_person = @berner_people.first
        post :search, :locale => I18n.locale, :bg_id => valid_person.id
        response.should redirect_to valid_person
      end
    end

    context 'with an invalid BG People ID' do
      before(:all) do
        @missing_person = Factory(:person)
        @missing_person.destroy
      end

      it 'redirects to the index page' do
        post :search, :locale => I18n.locale, :bg_id => @missing_person.id
        response.should redirect_to people_path
      end

      it 'sets a flash error' do
        post :search, :locale => I18n.locale, :bg_id => @missing_person.id
        flash[:error].should_not be_nil
      end
    end

    context 'with search params' do
      context 'and 1 search result' do
        before(:each) do
          @result = @berner_people.first
          Person.should_receive(:matching_any).and_return([@result])
        end

        it 'redirects to the matching person page' do
          post :search, :locale => I18n.locale, :person => {:first_name => 'foo'}
          response.should redirect_to @result
        end
      end

      context 'and != 1 search result' do
        before(:each) do
          Person.should_receive(:matching_any).and_return(@berner_people)
        end

        it 'displays the search results' do
          post :search, :locale => I18n.locale, :person => {:first_name => 'foo'}
          response.should be_success
          response.should render_template 'search'
        end
      end
    end
  end

  describe '#show' do
    context 'with an invalid person id' do
      it 'redirects to the index page' do
        missing_person = Factory(:person)
        missing_person.destroy
        get :show, :locale => I18n.locale, :id => missing_person.id
        response.should redirect_to people_path
      end
    end

    context 'with a valid person id' do
      it 'loads the specified person' do
        valid_person = @berner_people.first
        get :show, :locale => I18n.locale, :id => valid_person.id
        assigns[:person].should == valid_person
      end

      it 'displays the person info' do
        valid_person = @berner_people.first
        get :show, :locale => I18n.locale, :id => valid_person.id
        response.should render_template 'show'
      end
    end
  end
end
