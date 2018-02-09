class InlineFormsCreateJoinTableUserRole < ActiveRecord::Migration
  def self.up
    create_table  :roles_users, :id => false, :force => true do |t|
      t.integer   :role_id
      t.integer   :user_id
    end
    execute 'INSERT INTO roles_users VALUES (1,1);'
  end

  def self.down
    drop_table roles_users
  end
end
