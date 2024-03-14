require 'rails_helper'

RSpec.describe SyncNotesJob, type: :job do
  describe '#perform' do
    let(:notes_data) { [{ 'title' => 'Test note', 'content' => 'Content 1' }] }

    before do
      allow(ExternalNotesService).to receive(:call).and_return(notes_data)
    end

    it 'creates notes in the database' do
      expect do
        described_class.perform
      end.to change { Note.count }.by(1)

      expect(Note.last.title).to eq('Test note')
      expect(Note.last.content).to eq('Content 1')
    end
  end
end
