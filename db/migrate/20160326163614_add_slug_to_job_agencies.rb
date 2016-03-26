class AddSlugToJobAgencies < ActiveRecord::Migration
  def change
    add_column :job_agencies, :slug, :string
    add_index :job_agencies, :slug, unique: true
  end
end
