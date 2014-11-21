class AddCommentToReportPhoto < ActiveRecord::Migration
  def up
    add_column :report_photos, :comment, :string
  end

  def down
    remove_column :report_photos, :comment
  end
end
