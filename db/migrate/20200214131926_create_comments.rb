class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user
      t.references :post
      t.string :content, null: false
      t.timestamps
    end
  end
end
