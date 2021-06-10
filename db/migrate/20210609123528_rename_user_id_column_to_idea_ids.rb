class RenameUserIdColumnToIdeaIds < ActiveRecord::Migration[5.2]
  def change
    rename_column :idea_tags, :user_id, :idea_id
  end
end
