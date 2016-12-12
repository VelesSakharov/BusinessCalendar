# frozen_string_literal: true
class AddHeadToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :head, :boolean, default: false
  end
end
