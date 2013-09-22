class CreateVolumes < ActiveRecord::Migration
  def change
    create_table :volumes do |t|
      t.integer :cv_id
      t.string :name
      t.integer :start_year
      t.integer :publisher_id

      t.timestamps
    end
  end
end
