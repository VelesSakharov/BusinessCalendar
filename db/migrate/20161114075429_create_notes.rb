class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :content
      t.datetime :appointment
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
