class CreateCreators < ActiveRecord::Migration
  def change
    create_table :creators, :id => false do |t|
      t.integer :issue_id
      t.integer :person_id
      t.integer :role_id      

      t.timestamps
    end
  end
end
