class AddTimestampsToPictures < ActiveRecord::Migration[5.0]
  def change
    add_timestamps :pictures, default: Time.zone.now
  end
end
