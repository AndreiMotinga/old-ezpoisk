require "rails_helper"

describe "Questions" do
  describe "GET #index" do
    it "renders index temlpate" do
      create :question

      get questions_path

      expect(response).to render_template(:index)
    end
  end
end
