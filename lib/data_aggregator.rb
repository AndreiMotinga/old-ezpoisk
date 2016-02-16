class DataAggregator
  def total_users_posts
    ReAgency.count + RePrivate.count + ReCommercial.count + JobAgency.count +
      Job.count + Service.count
  end

  def total_qa
    Question.count + Answer.count
  end

  def total_users
    User.count
  end

  def message
    string = "Общая статистика сайта\n"
    string += "Всего пользователей: #{total_users}\n"
    string += "Всего объявлений: #{total_users_posts}\n"
    string += "Всего Q&A: #{total_qa}\n"
    string += "==============================================\n"
    string
  end
end
