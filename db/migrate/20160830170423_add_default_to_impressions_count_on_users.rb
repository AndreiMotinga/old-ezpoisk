class AddDefaultToImpressionsCountOnUsers < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:users, :impressions_count, 0)
  end
end
