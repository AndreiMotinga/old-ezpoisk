# frozen_string_literal: true

module Media
  # load vk/fb groups from public/#{vk|fb}_groups.json file
  class Groups
    def initialize(file)
      @file = file
    end

    def groups
      data = File.read(@file)
      json = JSON.parse(data, symbolize_names: true)
      json[:groups]
    end
  end
end
