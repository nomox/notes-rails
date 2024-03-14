class SyncNotesJob
  @queue = :sync_notes_queue

  def self.perform
    notes_data = ExternalNotesService.call(HttpClient.new)

    notes_data.each do |note_data|
      note = Note.find_or_initialize_by(title: note_data['title'])
      note.content = note_data['content']
      note.save!
    end
  end
end
