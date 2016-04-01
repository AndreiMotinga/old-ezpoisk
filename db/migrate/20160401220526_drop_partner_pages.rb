class DropPartnerPages < ActiveRecord::Migration
  def change
    drop_table :partner_pages
  end
end
