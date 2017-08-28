require "rails_helper"

describe "Answers" do
  describe "GET #show" do
    it "renders show template with listing" do
      answer = create :answer

      get answer_path answer

      expect(response).to render_template(:show)
      expect(response.body).to include(answer.title)
    end
  end
end
