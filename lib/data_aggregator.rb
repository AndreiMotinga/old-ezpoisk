class DataAggregator
  def initialize
    @listings_count = models.map{|m| m.till_last_week.count}.sum
    # @listings_goal = (@listings_count * 0.33).round
    @listings_goal = 400

    @users_goal = (User.count * 0.33).round
    # @answer_goal = (Answer.count * 0.33).round
    @answer_goal = 25

    # @posts_goal = (Post.count * 0.33).round
    @posts_goal = 180
  end

  def message
    "Общая статистика сайта
     Alina | Объявления:
     Всего:  #{@listings_count}, Цель: #{@listings_goal}, Достигнуто: #{this_week}

     Dasha | Ответы:
     Всего: #{Answer.count}, Цель:#{@answer_goal}, Достигнуто: #{Answer.week}

     Rustam | Новости:
     Всего:  #{Post.count}, Цель: #{@posts_goal}, Достигнуто: #{Post.week}"

     # Users:
     # Всего: #{User.count}, Цель: #{@users_goal} , Достигнуто: #{User.this_week}
  end

  def this_week
    # todo this should just be entries
    models.map(&:week).sum
  end

  def models
    [RePrivate, Job, Service, Sale]
  end
end
