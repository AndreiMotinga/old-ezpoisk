u = User.find 84

job = Compaign.create(title: "Работа", user_id: 84 )
re = Compaign.create(title: "Недвижимость", user_id: 84 )
sale = Compaign.create(title: "Продажи", user_id: 84 )

Partner.create(
  campaign: job,
  tilte: "Объявления о работе 1",
  headline: "Доска объявений ezpoisk.com",
  final_url: "https://www.ezpoisk.com/объявления/работа",
  description: "Доска беслптаных объявлений в США. Работа недвижимость объявления"
)

Partner.create(
  campaign: job,
  tilte: "Объявления о работе 2",
  headline: "Доска объявений ezpoisk.com 2",
  final_url: "https://www.ezpoisk.com/объявления/работа 2",
  description: "Доска беслптаных объявлений в США. Работа недвижимость объявления"
)
