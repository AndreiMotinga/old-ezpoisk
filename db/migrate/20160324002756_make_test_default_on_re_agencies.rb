class MakeTestDefaultOnReAgencies < ActiveRecord::Migration
  def change
    change_column :re_agencies, :description, :text, default: ""
  end
end
