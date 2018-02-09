class AddSlugToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :slug, :string
  end
end
