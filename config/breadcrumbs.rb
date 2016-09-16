crumb :root do
  link "Домашняя", root_path
end

crumb :re_privates do
  link "Недвижимость", re_privates_path
end

crumb :re_private do |re_private|
  link re_private.name, re_private
  parent :re_privates
end

crumb :jobs do
  link "Работа", jobs_path
end

crumb :job do |job|
  link job.title, job
  parent :jobs
end

crumb :sales do
  link "Продажи", sales_path
end

crumb :sale do |sale|
  link sale.title, sale
  parent :sales
end

crumb :services do
  link "Услуги", services_path
end

crumb :service do |service|
  link service.title, service
  parent :services
end

crumb :posts do
  link "Новости", posts_path
end

crumb :post do |post|
  link post.title, post
  parent :posts
end

crumb :answers do
  link "Ответы", answers_path
end

crumb :answer do |answer|
  link answer.title, answer
  parent :answers
end

crumb :new_answer do |q|
  # todo #when answers moved to dashboard fix path
  link "Новое", root_path
  parent :answers
end

crumb :tag_answers do |name|
  link name, tag_answers_path(name)
  parent :answers
end

crumb :edit_question_answer_path do |answer|
  link answer.title, edit_answer_path(answer)
  parent :answers
end

crumb :questions do
  link "Вопросы", questions_path
end

crumb :question do |question|
  link question.title, question
  parent :questions
end

crumb :new_question do
  link "Новое", new_question_path
  parent :questions
end

crumb :unanswered_questions_path do
  link "Неотвеченные", questions_path
  parent :questions
end

crumb :tag_questions_path do |tag|
  link tag, tag_questions_path(tag)
  parent :questions
end

crumb :unanswered_tag_questions_path do |tag|
  link tag, unanswered_tag_questions_path(tag)
  parent :unanswered_questions_path
end

crumb :partners do |user|
  link "Реклама", dashboard_partners_path
  parent :dashboard, user
end

crumb :edit_partner do |user, partner|
  link partner.title, edit_dashboard_partner_path(partner)
  parent :partners, user
end

crumb :new_partner do |user|
  link "Новый банер", new_dashboard_partner_path
  parent :partners, user
end

crumb :dashboard do |user|
  link "Панель Управления", edit_dashboard_user_path(user)
end

crumb :edit_dashboard_user_path do |user|
  link "Мои настройки", edit_dashboard_user_path(user)
  parent :dashboard, user
end

crumb :dashboard_favorites_path do |user|
  link "Мои закладки", dashboard_favorites_path
  parent :dashboard, user
end

crumb :dashboard_re_privates_path do |user|
  link "Недвижимость", dashboard_re_privates_path
  parent :dashboard, user
end

crumb :edit_dashboard_re_private_path do |user, re_private|
  link re_private.name, edit_dashboard_re_private_path(re_private)
  parent :dashboard_re_privates_path, user
end

crumb :new_dashboard_re_private_path do |user|
  link "Новое", new_dashboard_re_private_path
  parent :dashboard_re_privates_path, user
end

crumb :dashboard_jobs_path do |user|
  link "Работа", dashboard_jobs_path
  parent :dashboard, user
end

crumb :edit_dashboard_job_path do |user, job|
  link job.title, edit_dashboard_job_path(job)
  parent :dashboard_jobs_path, user
end

crumb :new_dashboard_job_path do |user|
  link "Новое", new_dashboard_job_path
  parent :dashboard_jobs_path, user
end

crumb :dashboard_sales_path do |user|
  link "Продажи", dashboard_sales_path
  parent :dashboard, user
end

crumb :edit_dashboard_sale_path do |user, sale|
  link sale.title, edit_dashboard_sale_path(sale)
  parent :dashboard_sales_path, user
end

crumb :new_dashboard_sale_path do |user|
  link "Новое", new_dashboard_sale_path
  parent :dashboard_sales_path, user
end

crumb :dashboard_services_path do |user|
  link "Услуги", dashboard_services_path
  parent :dashboard, user
end

crumb :edit_dashboard_service_path do |user, service|
  link service.title, edit_dashboard_service_path(service)
  parent :dashboard_services_path, user
end

crumb :new_dashboard_service_path do |user|
  link "Новое", new_dashboard_service_path
  parent :dashboard_services_path, user
end

crumb :dashboard_posts_path do |user|
  link "Новости", dashboard_posts_path
  parent :dashboard, user
end

crumb :edit_dashboard_post_path do |user, post|
  link post.title, edit_dashboard_post_path(post)
  parent :dashboard_posts_path, user
end

crumb :new_dashboard_post_path do |user|
  link "Новое", new_dashboard_post_path
  parent :dashboard_posts_path, user
end

crumb :dashboard_answers_path do |user|
  link "Ответы", dashboard_answers_path
  parent :dashboard, user
end

crumb :dashboard_reviews_path do |user|
  link "Отзывы", dashboard_reviews_path
  parent :dashboard, user
end

crumb :edit_dashboard_review_path do |user, review|
  link review.id, edit_dashboard_review_path(review)
  parent :dashboard_reviews_path, user
end

crumb :new_dashboard_review_path do |user|
  link "Отзывы", new_dashboard_review_path
  parent :dashboard_reviews_path, user
end
