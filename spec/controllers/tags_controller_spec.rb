require 'spec_helper'

describe TagsController do
  context ':show' do
    it 'should work' do
      t = Tag.create! name: 'Test'
      get :show, { id: t.slug }
      expect(response).to be_success
    end
  end
end
