require 'rails_helper'

RSpec.describe Api::V1::NotesController, type: :controller do
  fixtures :notes

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    context 'with search query' do
      let!(:note) { notes(:note1) }

      it 'returns notes matching the search query' do
        get :index, params: { search: 'first' }

        expect(response).to be_successful

        body = JSON.parse(response.body)
        expect(body['notes']).to contain_exactly(include('id' => note.id, 'title' => 'My first note'))
      end
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new note' do
        expect do
          post :create, params: { note: { title: 'Test Note', content: 'Note Content' } }
        end.to change(Note, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new note' do
        expect do
          post :create, params: { note: { title: '', content: 'Note Content' } }
        end.to_not change(Note, :count)

        expect(response).to have_http_status(:unprocessable_entity)

        body = JSON.parse(response.body)
        expect(body['validation_errors'])
          .to include('title' => ["can't be blank", 'is too short (minimum is 3 characters)'])
      end
    end
  end

  describe 'GET #show' do
    let(:note) { Note.create(title: 'Test Note', content: 'Note Content') }

    it 'returns a success response' do
      get :show, params: { id: note.to_param }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    let!(:note) { Note.create(title: 'Test Note', content: 'Note Content') }

    context 'with valid parameters' do
      it 'updates the requested note' do
        new_title = 'Updated Title'
        put :update, params: { id: note.to_param, note: { title: new_title } }
        note.reload
        expect(note.title).to eq(new_title)
      end
    end

    context 'with invalid parameters' do
      it 'does not update the note' do
        put :update, params: { id: note.to_param, note: { title: '' } }
        note.reload
        expect(note.title).not_to eq('')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:note) { Note.create(title: 'My Note', content: 'Note Content') }

    it 'destroys the requested note' do
      expect do
        delete :destroy, params: { id: note.to_param }
      end.to change(Note, :count).by(-1)

      expect(response).to be_successful
    end
  end
end
