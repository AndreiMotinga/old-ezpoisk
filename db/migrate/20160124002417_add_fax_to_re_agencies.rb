class AddFaxToReAgencies < ActiveRecord::Migration
  def change
    add_column :re_agencies, :fax, :string
  end
end
