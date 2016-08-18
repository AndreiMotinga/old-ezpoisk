class DataAggregator
  def initialize
    @listings_count = models.map{|m| m.till_last_week.count}.sum
    @listings_goal = (@listings_count * 0.33).round

    @users_goal = (User.count * 0.33).round
    @answer_goal = (Answer.count * 0.33).round

    @posts_goal = (Post.count * 0.33).round
  end

  def message
    "Общая статистика сайта
     Объявления:
     Всего:  #{@listings_count}, Цель: #{@listings_goal}, Достигнуто: #{this_week}

     Ответы:
     Всего: #{Answer.count}, Цель:#{@answer_goal}, Достигнуто: #{Answer.this_week}
     "
     # Новости:
     # Всего:  #{Post.count}, Цель: #{@posts_goal}, Достигнуто: #{Post.this_week}
     #
     # Users:
     # Всего: #{User.count}, Цель: #{@users_goal} , Достигнуто: #{User.this_week}
  end

  def this_week
    models.map(&:this_week).sum
  end

  def models
    [RePrivate, ReCommercial, Job, Service, Sale]
  end
end
