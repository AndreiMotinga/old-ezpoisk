require "rails_helper"

describe "Answers" do
  it "renders index" do
    user = create_and_login_user
    answer = create :answer, user: user

    get "/dashboard/answers"

    expect(response).to render_template(:index)
    expect(response.body).to include(answer.title)
  end
end
