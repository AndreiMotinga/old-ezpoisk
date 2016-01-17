class HoroscopesController < ApplicationController
  def index
    title = "%#{params[:title].mb_chars.downcase}%"
    @record = Horoscope.where("LOWER(title) LIKE ?", title).first
  end
end
