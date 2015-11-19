module ApplicationHelper

  def project_total_hours(project,date)
    project.total_hours_in_month(date.month,date.year)
  end

  def flash_message
    if flash[:notice] || flash[:alert]
      message = flash[:notice] || flash[:alert]
      clas = message.include?("not")? "alert": "notice";
      show_flash(message,clas)
    end
  end


private

  def show_flash(message,clas)
    content_tag :div, class: "message_#{clas}" do
      content_tag :p do
        message
      end
    end
  end

=begin
  def flash_message
    if flash[:alert]
      content_tag :div, class: "message_alert" do
        content_tag :p do
          flash[:alert]
        end
      end
    elsif flash[:notice]
      content_tag :div, class: "message_notice" do 
        content_tag :p do
          flash[:notice]
        end
      end
    end
  end
=end


end
