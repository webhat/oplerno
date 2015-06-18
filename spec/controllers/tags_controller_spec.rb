require 'spec_helper'

describe TagsController do
  context ':show' do
    it 'should work' do
      t = Tag.create! name: 'Test'
      get :show, { id: t.slug }
      expect(response).to be_success
    end
    it 'should work' do
      t = Tag.create! name: 'Test'
      get :show, { id: t.slug }
      expect(response.status).to eq 200
    end
  end
  context ':destroy' do
    let(:mentor) { create :mentor }
    it 'should work' do
      t = Tag.create! name: 'Test'
      delete :destroy, { mentor_id: mentor.id, id: t.id, tag: {name:'test'} }
      expect(response).to be_success
    end
  end
  context ':create' do
    let(:mentor) { create :mentor }
    it 'should work' do
      post :create, { mentor_id: mentor.id, tag: {name:'test'} }
      expect(response).to be_success
    end
  end
  context ':update' do
    let(:mentor) { create :mentor }
    it 'should work' do
      t = Tag.create! name: 'Test'
      put :update, { mentor_id: mentor.id, id: t.slug, tag: {name: 'test'} }
      expect(response).to be_success
    end
    it 'should update name' do
      t = Tag.create! name: 'Test'
      expected = 'test'

      put :update, { mentor_id: mentor.id, id: t.slug, tag: {name: expected} }
      t.reload
      expect(t.name).to eq expected
    end
  end
end
