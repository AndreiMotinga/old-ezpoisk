class DataAggregator
  def total_users_posts
    ReAgency.count + RePrivate.count + ReCommercial.count + JobAgency.count +
      Job.count + Service.count
  end

  def total_users
    User.count
  end

  def forum_posts_count
    Forem::Post.count
  end

  def message
    string = "Общая статистика сайта\n"
    string += "Всего пользователей: #{total_users}\n"
    string += "Всего обьявлений: #{total_users_posts}\n"
    string += "Всего постов на форуме: #{forum_posts_count}\n"
    string += "==============================================\n"
    string
  end
end
