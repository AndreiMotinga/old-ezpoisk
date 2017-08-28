require "rails_helper"

describe "Answers GET #index", type: :request do
  it "renders index temlpate" do
    get answers_path

    expect(response).to render_template(:index)
  end

  it "filters by term" do
    first = create :answer, created_at: 1.hour.ago, text: "Какой то текст тут"
    second = create :answer, text: "Другая инфа которую не нужно возвращать"

    get answers_path, params: { term: "текст" }

    expect(response.body).to include(first.title)
    expect(response.body).to_not include(second.title)
  end

  context "user not logged in" do
    it "renders all answers" do
      first = create :answer, created_at: 1.hour.ago
      second = create :answer

      get answers_path

      expect(response.body).to include(first.title)
      expect(response.body).to include(second.title)
    end
  end

  context "user logged in" do
    # context "user doesn't have interesets" do
    #   it "prompts user to enter interesets" do
    #     sign_in(@user = create(:user))
    #
    #     get answers_path
    #
    #     expect(response.body).to include("Укажите ваши интересы")
    #   end
    #
    #   it "doesn't render answers" do
    #     first = create :answer
    #     sign_in(@user = create(:user))
    #
    #     get answers_path
    #
    #     expect(response.body).to_not include(first.title)
    #   end
    # end

    # context "user has interesets" do
    #   it "renders answers user is intereted in" do
    #     first = create :answer, tag_list: ["недвижимость"]
    #     second = create :answer, tag_list: ["работа"]
    #     @user = create :user, interest_list: ["работа"]
    #     sign_in(@user)
    #
    #     get answers_path
    #
    #     expect(response.body).to include(second.title)
    #     expect(response.body).to_not include(first.title)
    #   end
    # end

    context "show all" do
      it "shows all answers if params[:all] present" do
        first = create :answer, tag_list: ["недвижимость"]
        second = create :answer, tag_list: ["работа"]
        @user = create :user, interest_list: ["работа"]
        sign_in(@user)

        get answers_path, params: { all: true }

        expect(response.body).to include(second.title)
        expect(response.body).to include(first.title)
      end
    end
  end
end
