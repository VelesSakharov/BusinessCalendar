# frozen_string_literal: true
class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.string :name, null: false, limit: 255
      t.string :description, limit: 1023

      t.timestamps
    end
  end
end
