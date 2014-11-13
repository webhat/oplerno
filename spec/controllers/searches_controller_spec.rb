require 'spec_helper'

describe SearchesController do
	context 'when I search for something' do
		it 'should return something' do
			pending 'setup searchkick on Travis CI'
			get :index, {}
		end
		it 'should return something' do
			pending 'setup searchkick on Travis CI'
			get :create, { search: { term: 'test' } }
		end
	end
end
