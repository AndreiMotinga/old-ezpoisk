class AddStateToPartners < ActiveRecord::Migration
  def change
    add_reference :partners, :state, index: true, foreign_key: true
  end
end
