require 'rails_helper'

RSpec.describe NotesQuery do
  fixtures :notes

  describe '#call' do
    let!(:note1) { notes(:note1) }
    let!(:note2) { notes(:note2) }

    context 'when search query is present' do
      it 'returns notes matching the search' do
        query = NotesQuery.new(search: 'My first')
        result = query.call

        expect(result).to include(note1)
        expect(result).not_to include(note2)
      end
    end

    context 'when search query is not present' do
      it 'returns all notes' do
        query = NotesQuery.new
        result = query.call

        expect(result).to include(note1)
        expect(result).to include(note2)
      end
    end
  end
end
