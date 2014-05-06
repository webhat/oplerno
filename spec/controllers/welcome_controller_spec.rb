require 'spec_helper'

describe WelcomeController do
	context 'when getting the frontpage' do
		render_views
		it 'should render welcome#index' do
			get :index
			response.should render_template('index')
		end
		it 'should have a link to www.oplerno.com' do
			pending 'what?'
			get :index
			response.body.should =~ /www.oplerno.com/
		end
		it 'should have an overview of courses'
		it 'should have an overview of teachers'
	end
end
