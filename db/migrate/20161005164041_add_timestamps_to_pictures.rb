class AddTimestampsToPictures < ActiveRecord::Migration[5.0]
  def change
    add_timestamps :pictures
  end
end
