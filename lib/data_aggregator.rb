class DataAggregator
  def initialize
    @post_count = total_users_posts
    @post_goal = (@post_count * 0.1).round

    @user_count = User.count
    @users_goal = (@user_count * 0.1).round

    @answer_count = Answer.count
    @answer_goal = (@answer_count * 0.1).round
    @beginning_of_week = Date.today.at_beginning_of_week
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
    User.where("created_at > ?", @beginning_of_week).count
  end

  def this_week_answers
    Answer.where("created_at > ?", @beginning_of_week).count
  end

  def this_week_posts
    count = RePrivate.where("created_at > ?", @beginning_of_week).count
    [ReCommercial, Service, Job, Sale].each do |model|
      count += model.where("created_at > ?", @beginning_of_week).count
    end
    count
  end

  def total_users_posts
    RePrivate.count + ReCommercial.count + Job.count + Service.count
  end

  def total_qa
    Question.count + Answer.count
  end

  def total_users
    User.count
  end

end
