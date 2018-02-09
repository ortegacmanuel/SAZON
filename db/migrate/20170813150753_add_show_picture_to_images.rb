class AddShowPictureToImages < ActiveRecord::Migration[5.0]
  def change
    add_column :images, :lightbox_show_picture, :integer, default: 1
  end
end
