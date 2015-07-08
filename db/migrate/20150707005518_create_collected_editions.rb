class CreateCollectedEditions < ActiveRecord::Migration
  def change
    create_table :collected_editions do |t|
      t.string :name
      t.string :volume_number
      t.integer :volume_id
      t.string :cv_id
      t.string :site_detail_url
      t.string :cover_file_name
      t.string :cover_content_type
      t.string :cover_file_size
      t.string :cover_updated_at

      t.timestamps
    end
  end
end
