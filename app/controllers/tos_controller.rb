# frozen_string_literal: true

class TosController < ApplicationController
  def tos
    data = open("https://s3.amazonaws.com/ezpoisk/tos.pdf")
    send_data data.read,
              filename: "tos",
              type: "application/pdf",
              disposition: "inline",
              stream: "true",
              buffer_size: "4096"
  end
end
