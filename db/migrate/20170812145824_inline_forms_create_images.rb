class InlineFormsCreateImages < ActiveRecord::Migration

  def self.up
    create_table :images do |t|
      t.string :name
      t.string :caption
      t.string :image
      t.text :description
      t.belongs_to :document
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end

end
