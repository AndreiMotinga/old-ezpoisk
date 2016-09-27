require "rails_helper"

describe Title do
  describe "#title" do
    it "return text when string is to short" do
      text = "Ищу работу. На кэщ. Манхэттен или Бруклин."

      result = Title.new(text).title
      expect(result).to eq text
    end

    it "returns text untill first comma" do
      text = "Ищем сотрудника в оффис, звонить, писать имеилы на хорошую работу"

      result = Title.new(text).title
      expect(result).to eq "Ищем сотрудника в оффис"
    end

    it "returns text untill first dot" do
      text = "Ищем сотрудника в оффис, звонить, писать имеилы."

      result = Title.new(text).title
      expect(result).to eq text
    end

    it "returns default title for non of the obove" do
      text = "Ищем сотрудника в оффис звонить писать имеилы really long sentenc"

      result = Title.new(text, "Работа").title
      expect(result).to eq "Работа"
    end
  end
end
