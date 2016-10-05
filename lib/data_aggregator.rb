class DataAggregator
  def initialize
    @listings_count = models.map{|m| m.last_week.count}.sum
    # @listings_goal = (@listings_count * 0.33).round
    @listings_goal = 400

    @users_goal = (User.count * 0.33).round
    # @answer_goal = (Answer.count * 0.33).round
    @answer_goal = 25

    # @posts_goal = (Post.count * 0.33).round
    @posts_goal = 180
  end

  def message
    # | Users             | #{User.count}      | #{@users_goal}      | #{User.week.count}                         | #{User.today.count}
    <<-eos
    Статистика
     ---------------------------------------------------------------------------------------------
    |Категория    | Всего  | Цель    | Достигнуто      | Сегодня
     ---------------------------------------------------------------------------------------------
    | Объявления | #{@listings_count}   | #{@listings_goal}      | #{this_week}                     | #{this_day}
    | Ответы         | #{Answer.count}      | #{@answer_goal}        | #{Answer.week.count}                         | #{Answer.today.count}
     eos
  end

  def this_week
    models.map{ |m| m.active.week.count }.sum
  end

  def this_day
    models.map{ |m| m.active.today.count }.sum
  end

  def models
    [RePrivate, Job, Service, Sale]
  end
end
