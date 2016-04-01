class DataAggregator
  def initialize
    @post_count = total_users_posts
    @post_goal = (@post_count * 0.1).round

    @user_count = User.count
    @users_goal = (@user_count * 0.1).round

    @answer_count = Answer.count
    @answer_goal = (@answer_count * 0.1).round
  end

  def message
    string = "Общая статистика сайта\n"
    string += "Users:  \n"
    string += "Всего:  #{@user_count}, Неделя: #{this_week_users}, Цель: #{@users_goal}\n"
    string += "Ответы:  \n"
    string += "Всего:  #{@answer_count}, Неделя: #{this_week_answers}, Цель: #{@answer_goal}\n"
    string += "Объявления:  \n"
    string += "Всего:  #{@post_count}, Неделя: #{this_week_posts}, Цель: #{@post_goal}\n"
    string
  end

  def this_week_users
    User.where("created_at > ?", 1.week.ago).count
  end

  def this_week_answers
    Answer.where("created_at > ?", 1.week.ago).count
  end

  def this_week_posts
    count = RePrivate.where("created_at > ?", 1.week.ago).count
    [ReAgency, ReCommercial, ReFinance, Service, JobAgency, Job, Sale].each do |model|
      count += model.where("created_at > ?", 1.week.ago).count
    end
    count
  end

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

end
