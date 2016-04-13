module ProfilesHelper
  def user_motto
    return @profile.motto if @profile.motto.present?
    if current_user == @profile.user
      return link_to "добавьте свое мотто", edit_dashboard_profile_path(@profile), class: "text-muted", target: "_blank"
    end
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

  def profile_has_any_links?
    return true if @profile.facebook.present?
    return true if @profile.google.present?
    return true if @profile.twitter.present?
    return true if @profile.vk.present?
    return true if @profile.ok.present?
  end

  def profile_has_contacts?
    return true if @profile.phone.present?
    return true if @profile.site.present?
  end
end
