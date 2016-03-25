class WeeklyReport

  def message
    string = "===========================================================\n"
    string += "===========================================================\n"
    string += "Недельный отчет \n"
    string += "Users:  \n"
    string += "Всего:  #{User.count}, Неделя: #{this_week_users}\n"
    string += "Ответы:  \n"
    string += "Всего:  #{Answer.count}, Неделя: #{this_week_answers}\n"
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
