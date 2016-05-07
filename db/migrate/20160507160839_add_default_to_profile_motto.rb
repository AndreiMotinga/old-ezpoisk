class AddDefaultToProfileMotto < ActiveRecord::Migration
  def change
    change_column_default :profiles, :motto, "Пользователь не продавставил информации"
  end
end
