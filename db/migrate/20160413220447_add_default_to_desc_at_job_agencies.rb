class AddDefaultToDescAtJobAgencies < ActiveRecord::Migration
  def change
    change_column :job_agencies, :description, :text, default: "", null: false
  end
end
