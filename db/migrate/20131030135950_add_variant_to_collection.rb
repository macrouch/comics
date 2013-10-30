class AddVariantToCollection < ActiveRecord::Migration
  def change
    add_column :collections, :variant_name, :string
    add_column :collections, :variant_file_name, :string
    add_column :collections, :variant_content_type, :string
    add_column :collections, :variant_file_size, :integer
    add_column :collections, :variant_updated_at, :datetime
  end
end
