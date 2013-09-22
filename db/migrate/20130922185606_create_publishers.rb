class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.integer :cv_id
      t.string :name

      t.timestamps
    end
  end
end
