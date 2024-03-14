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

  def search(relation, search_query)
    relation.where('MATCH(title, content) AGAINST(?)', search_query)
  end
end
