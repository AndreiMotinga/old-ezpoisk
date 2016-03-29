class DataAggregator
  def total_users_posts
    ReAgency.count + RePrivate.count + ReFinance.count + ReCommercial.count +
      JobAgency.count + Job.count + Service.count
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

  def this_week_posts
    count = RePrivate.where("created_at > ?", 1.week.ago).count
    [ReAgency, ReCommercial, ReFinance, Service, JobAgency, Job, Sale].each do |model|
      count += model.where("created_at > ?", 1.week.ago).count
    end
    count
  end
end
