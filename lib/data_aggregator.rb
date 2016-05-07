class DataAggregator
  def initialize
    @post_count = models.map(&:count).sum
    @post_goal = (@post_count * 0.1).round

    @users_goal = (User.count * 0.1).round
    @answer_goal = (Answer.count * 0.1).round
  end

  def message
    "Общая статистика сайта
     Users:
     Всего: #{User.count}, Неделя: #{User.this_week}, Цель: #{@users_goal}
     Ответы:
     Всего: #{Answer.count}, Неделя: #{Answer.this_week}, Цель:#{@answer_goal}
     Объявления:
     Всего:  #{@post_count}, Неделя: #{this_week}, Цель: #{@post_goal}"
  end

  def this_week
    models.map(&:this_week).sum
  end

  def models
    MODELS.map { |model| model[1].constantize }
  end
end
