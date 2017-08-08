require "rails_helper"

describe "Questions" do
  describe "GET #show" do
    it "renders show template with listing" do
      q = create :question

      get question_path q

      expect(response).to render_template(:show)
      expect(response.body).to include(q.title)
    end
  end
end
