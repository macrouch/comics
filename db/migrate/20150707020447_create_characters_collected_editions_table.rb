class CreateCharactersCollectedEditionsTable < ActiveRecord::Migration
  def change
    create_table :characters_collected_editions do |t|
      t.references :collected_edition
      t.references :character
    end
  end
end
