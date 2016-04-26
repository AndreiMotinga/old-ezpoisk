class AddActiveUntilToServices < ActiveRecord::Migration
  def change
    add_column :services, :active_until, :date
    Service.find_each do |s|
      s.active_until = Date.today + 1.month
      s.save
    end
  end
end

