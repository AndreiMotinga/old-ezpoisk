require "rails_helper"

describe "Answers" do
  describe "GET #index" do
    it "renders index temlpate" do
      get answers_path

      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "renders show template with listing" do
      answer = create :answer

      get answer_path answer

      expect(response).to render_template(:show)
      expect(response.body).to include(answer.title)
    end
  end
end
