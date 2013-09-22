class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.integer :cv_id
      t.string :issue_number
      t.string :name
      t.string :site_detail_url
      t.datetime :store_date
      t.integer :volume_id
      t.string :cover_file_name
      t.string :cover_content_type
      t.integer :cover_file_size
      t.datetime :cover_updated_at

      t.timestamps
    end
  end
end
