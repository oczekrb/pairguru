class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user, index: true, null: false
      t.references :movie, index: true, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
