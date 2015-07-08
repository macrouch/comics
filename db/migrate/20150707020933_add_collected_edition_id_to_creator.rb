class AddCollectedEditionIdToCreator < ActiveRecord::Migration
  def change
    add_column :creators, :collected_edition_id, :integer
  end
end
