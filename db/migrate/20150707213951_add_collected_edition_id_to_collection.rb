class AddCollectedEditionIdToCollection < ActiveRecord::Migration
  def change
    add_column :collections, :collected_edition_id, :integer
  end
end
