class CreateJoinTableRolesUsers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :roles, :users do |t|
      t.belongs_to :roles, index: true, null: false
      t.belongs_to :users, index: true, null: false

      # t.index [:role_id, :user_id]
      # t.index [:user_id, :role_id]
    end
  end
end
