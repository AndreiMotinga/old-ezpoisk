module ProfilesHelper
  def user_motto
    return @profile.motto if @profile.motto.present?
    "Пользователь не продавставил информации"
  end

  def work_to_show
    return @profile.work if @profile.work.present?
    "Пользователь не продавставил информации"
  end

  def about_to_show
    return @profile.about if @profile.about.present?
    "Пользователь не продавставил информации"
  end
end
