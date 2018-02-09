class InlineFormsCreateRoles < ActiveRecord::Migration

  def self.up
    #create_table :roles, :id => true do |t|
    create_table :roles do |t|
      t.string :name 
      t.text :description 
      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end

end
