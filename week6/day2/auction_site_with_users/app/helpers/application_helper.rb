module ApplicationHelper
  def flash_message
    get_message(:notice) || get_message(:alert)
  end

  def format_date(date)
    date.strftime("%d-%m-%Y")
  end

  def format_price(price)
    sprintf('%.2f', price)
  end

  private

  def get_message(type)
    if flash[type]
      content_tag :div, class: "message #{type.to_s}" do
        flash[type]
      end
    end
  end
end
