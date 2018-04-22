class AddIsIsmToBegrips < ActiveRecord::Migration[5.1]
  def up
    add_column :begrips, :is_ism, :integer, null: false, default: 0
  end

  def down
    remove_column :begrips, :is_ism, :integer, null: false, default: 0
  end
end
