class CreateIdeas < ActiveRecord::Migration[5.2]
  def change
    create_table :ideas do |t|
      t.integer :user_id
      t.string :title
      t.text :content
      t.string :icon_id
      t.string :presentation_id

      t.timestamps
    end
  end
end
