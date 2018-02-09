class InlineFormsCreateDocuments < ActiveRecord::Migration

  def self.up
    #create_table :documents, :id => true do |t|
    create_table :documents do |t|
      t.string :name
      t.string :title
      t.integer :document_id
      t.text :content
      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end

end
