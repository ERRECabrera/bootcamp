class SiteController < ApplicationController

  def index
    @today_concerts = Concert.where("date < ? and date > ?", Date.today, Date.yesterday)
    @month_concert = Concert.where("date > ? and date < ?", Date.today.at_beginning_of_month, Date.today)
    render "index"
  end

end
