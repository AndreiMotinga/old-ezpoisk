class AddCachedTagsOnJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :cached_tags, :string, default: ""
  end
end
