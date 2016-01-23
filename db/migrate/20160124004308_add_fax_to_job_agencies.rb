class AddFaxToJobAgencies < ActiveRecord::Migration
  def change
    add_column :job_agencies, :fax, :string
  end
end
