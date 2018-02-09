class AddSynonymToBegrips < ActiveRecord::Migration[5.0]
  def change
    add_column :begrips, :synonym, :string
  end
end
