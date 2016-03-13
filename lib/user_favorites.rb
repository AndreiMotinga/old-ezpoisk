class UserFavorites
  def initialize(user)
    @user = user
  end

  def favorite_posts
    @user.favorites.map do |favorite|
      model = favorite.post_type.constantize
      model.find(favorite.post_id)
    end
  end
end
