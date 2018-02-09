class AddMasonryToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :masonry_title_above, :integer, default: 1
    add_column :documents, :masonry_text_above, :integer, default: 1
    add_column :documents, :masonry_column_width, :integer, default: 200
    add_column :documents, :masonry_gutter_width, :integer, default: 10
  end
end
