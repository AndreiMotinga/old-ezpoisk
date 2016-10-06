require "rails_helper"

describe SocialTitle do
  describe "#title" do
    it "return text when string is to short" do
      text = "Ищу работу. на кэщ. манхэттен или бруклин."

      result = SocialTitle.new(text).title
      expect(result).to eq text
    end

    it "returns text untill first comma" do
      text = "Ищем сотрудника в оффис, звонить, писать имеилы на хорошую работу"

      result = SocialTitle.new(text).title
      expect(result).to eq "Ищем сотрудника в оффис"
    end

    it "returns text untill first dot" do
      text = "Ищем сотрудника в оффис, звонить, писать имеилы."

      result = SocialTitle.new(text).title
      expect(result).to eq text
    end

    it "returns default title for non of the obove" do
      text = "Ищем сотрудника в оффис звонить писать имеилы really long sentenc"

      result = SocialTitle.new(text, "Работа").title
      expect(result).to eq "Работа"
    end

    it "downcases and capitalizes string" do
      text = "ищем сотрудникА В ОФФИС ЗВОНИТЬ "

      result = SocialTitle.new(text, "").title
      expect(result).to eq "Ищем сотрудника в оффис звонить"
    end
  end
end
