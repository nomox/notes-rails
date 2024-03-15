class NotesQuery
  attr_reader :params, :relation

  def initialize(params = {}, relation = Note.all)
    @params   = params
    @relation = relation
  end

  def call
    @relation = search(@relation, params[:search]) if params[:search]
    @relation
  end

  private

  # The search functionality is implemented with MySQL Full-Text search by indexing relevant columns title and content
  # in the database table.
  def search(relation, search_query)
    relation.where('MATCH(title, content) AGAINST(?)', search_query)
  end
end
