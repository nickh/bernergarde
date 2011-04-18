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
    context 'without search params' do
      it 'displays the search form' do
        get :index
        response.should be_success
        response.should render_template 'search_form'
      end
    end

    context 'with a valid BG People ID' do
      it 'redirects to the person page' do
        valid_person = @berner_people.first
        get :index, :bg_id => valid_person.id
        response.should redirect_to valid_person
      end
    end

    context 'with an invalid BG People ID' do
      it 'displays the search form' do
        missing_person = Factory(:person)
        missing_person.destroy
        get :index, :bg_id => missing_person.id
        response.should be_success
        response.should render_template 'search_form'
      end
    end

    context 'with search params' do
      context 'and 1 search result' do
        before(:each) do
          @result = @berner_people.first
          Person.should_receive(:matching_any).and_return([@result])
        end

        it 'redirects to the matching person page' do
          get :index, :person => {:first_name => 'foo'}
          response.should redirect_to @result
        end
      end

      context 'and != 1 search result' do
        before(:each) do
          Person.should_receive(:matching_any).and_return(@berner_people)
        end

        it 'displays the search results' do
          get :index, :person => {:first_name => 'foo'}
          response.should be_success
          response.should render_template 'search_results'
        end
      end
    end
  end

  describe '#show' do
    context 'with an invalid person id' do
      it 'redirects to the index page' do
        missing_person = Factory(:person)
        missing_person.destroy
        get :show, :id => missing_person.id
        response.should redirect_to people_path
      end
    end

    context 'with a valid person id' do
      it 'loads the specified person' do
        valid_person = @berner_people.first
        get :show, :id => valid_person.id
        assigns[:person].should == valid_person
      end

      it 'displays the person info' do
        valid_person = @berner_people.first
        get :show, :id => valid_person.id
        response.should render_template 'show'
      end
    end
  end
end
