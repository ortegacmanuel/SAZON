class AddMenuOptionToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :which_menu, :integer, default: 1
  end
end
