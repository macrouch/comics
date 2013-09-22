class CreateIssuesCharactersTable < ActiveRecord::Migration
  def change
    create_table :issues_characters_tables do |t|
      t.references :issue
      t.references :character
    end
  end
end
