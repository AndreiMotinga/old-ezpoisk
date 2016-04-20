class AddDatesToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :start_date, :date
    add_column :partners, :end_date, :date
  end
end
