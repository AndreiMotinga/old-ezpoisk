require "rails_helper"

feature "Subscription is created upon creation of question" do
end

# feature "Subscription is created upon creation of answer" do
#   scenario "" do
#     user = create_and_login_user
#     question = create :question
#
#     visit question_path(question)
#     find("#to_answer").click
#     # todo how to set this?
#     find("div[contenteditable]").set("This is awesome blog.")
#     click_on "Сохранить"
#
#     subscription = Subscription.last
#
#     expect(subscription.question).to eq question
#     expect(subscription.user).to eq user
#   end
# end
