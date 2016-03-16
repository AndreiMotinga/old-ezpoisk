class AddImpressionsCountToJobAgencies < ActiveRecord::Migration
  def change
    add_column :job_agencies, :impressions_count, :integer, default: 0
  end
end
