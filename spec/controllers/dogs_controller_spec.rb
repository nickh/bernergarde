require 'spec_helper'

describe DogsController do
  describe '#index' do
    context 'without search params' do
      it 'displays the search form'
    end

    context 'with search params' do
      it 'displays the search results'
    end
  end

  describe '#show' do
    context 'with an invalid dog id' do
      it 'redirects to the index page'
    end

    context 'with a valid dog id' do
      it 'loads the specified dog'
      it 'displays the dog info'
    end
  end
end
