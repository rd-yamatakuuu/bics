class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :idea_id
      t.text :comment
      t.float :review

      t.timestamps
    end
  end
end
