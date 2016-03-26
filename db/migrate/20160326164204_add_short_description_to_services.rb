class AddShortDescriptionToServices < ActiveRecord::Migration
  def change
    add_column :services, :short_description, :string, default: ""

    Service.find_each do |service|
      service.short_description = service.slug
      service.slug = nil
      service.save!
    end
  end
end
