class ChangeAllCvIds < ActiveRecord::Migration
  def change
    change_column :volumes, :cv_id, :string
    change_column :issues, :cv_id, :string
    change_column :characters, :cv_id, :string
    change_column :people, :cv_id, :string
    change_column :publishers, :cv_id, :string
  end
end
