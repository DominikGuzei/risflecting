class RenamePostToQuestion < ActiveRecord::Migration
  def up
    rename_table :posts, :questions
    rename_column :comments, :post_id, :question_id
  end

  def down
    rename_table :questions, :posts
    rename_column :comments, :question_id, :post_id
  end
end
