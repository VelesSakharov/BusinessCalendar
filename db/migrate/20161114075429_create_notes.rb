# frozen_string_literal: true
class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.string :title, null: false, limit: 255
      t.text :content, limit: 1023
      t.datetime :appointment
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
