module ProfilesHelper
  def user_motto
    return @profile.motto if @profile.motto.present?
    "Пользователь не продавставил информации"
  end
end
