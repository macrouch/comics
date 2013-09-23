class CreateCharactersIssuesTable < ActiveRecord::Migration
  def change
    create_table :characters_issues do |t|
      t.references :issue
      t.references :character
    end
  end
end
