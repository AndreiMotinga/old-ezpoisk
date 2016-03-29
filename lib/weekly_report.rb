class WeeklyReport
  def initialize
    @data_aggregator = DataAggregator.new
    @post_count = @data_aggregator.total_users_posts
    @post_goal = (@post_count * 0.07).round
    @post_week = @data_aggregator.this_week_posts

    @user_count = User.count
    @users_goal = (@user_count * 0.07).round
    @user_week = this_week_users

    @answer_count = Answer.count
    @answer_goal = (@answer_count * 0.07).round
    @answer_week = this_week_answers
  end

  def message
    string = "===========================================================\n"
    string += "===========================================================\n"
    string += "Недельный отчет \n"
    string += "Users:  \n"
    string += "Всего:  #{@user_count}, Неделя: #{@user_week}, Цель: #{@users_goal}\n"
    string += "Ответы:  \n"
    string += "Всего:  #{@answer_count}, Неделя: #{@answer_week}, Цель: #{@answer_goal}\n"
    string += "Объявления:  \n"
    string += "Всего:  #{@post_count}, Неделя: #{@post_week}, Цель: #{@post_goal}\n"
    string += "===========================================================\n"
    string += "===========================================================\n"
    string
  end

  def this_week_users
    User.where("created_at > ?", 1.week.ago).count
  end

  def this_week_answers
    Answer.where("created_at > ?", 1.week.ago).count
  end
end
