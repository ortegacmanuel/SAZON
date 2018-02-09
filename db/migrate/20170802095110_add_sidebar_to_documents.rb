class AddSidebarToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :sidebar, :text
    add_column :documents, :sidebar_on, :integer, default: 1
  end
end
