class AddImpressionsCountToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :impressions_count, :integer, default: 0
  end
end
