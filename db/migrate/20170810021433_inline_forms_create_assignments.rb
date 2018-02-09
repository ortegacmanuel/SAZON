class InlineFormsCreateAssignments < ActiveRecord::Migration

  def self.up
    #create_table :assignments, :id => true do |t|
    create_table :assignments do |t|
      t.string :name 
      t.string :title 
      t.text :content 
      t.belongs_to :document 
      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end

end
