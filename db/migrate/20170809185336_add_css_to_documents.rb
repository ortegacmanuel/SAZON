class AddCssToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :css, :text
  end
end
