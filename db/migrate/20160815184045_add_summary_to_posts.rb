class AddSummaryToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :summary, :text
  end
end
