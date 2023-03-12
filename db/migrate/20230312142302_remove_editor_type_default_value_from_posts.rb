class RemoveEditorTypeDefaultValueFromPosts < ActiveRecord::Migration[7.0]
  def change
    change_column_default :posts, :editor_type, from: "markdown", to: nil
  end
end
