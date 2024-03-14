class AddFulltextIndexToNotes < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      ALTER TABLE notes ADD FULLTEXT INDEX fulltext_index (title, content)
    SQL
  end

  def down
    execute <<-SQL
      DROP INDEX fulltext_index ON notes
    SQL
  end
end
