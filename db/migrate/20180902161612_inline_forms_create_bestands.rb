class InlineFormsCreateBestands < ActiveRecord::Migration[5.0]

  def self.up
    create_table :bestands do |t|
      t.string :name 
      t.string :slug 
      t.string :file 
      t.timestamps
    end
  end

  def self.down
    drop_table :bestands
  end

end
