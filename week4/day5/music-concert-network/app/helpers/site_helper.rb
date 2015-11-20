module SiteHelper

  def table_generator_to_show_concert(arr_concerts)
    header_names = [:band, :venue, :city, :date, :price, :description]
    arr_concerts.each do |concert|
      fields_values = header_names.map {|atribute| return concert[atribute]}
      binding.pry
      content_tag(:table, :class =>"table table-reflow") do 
        content_tag(:thead) do 
          content_tag(:tr) do 
            header_names.each do |atribute|
              content_tag(:th, atribute)
            end
          end
        end
        content_tag(:tbody) do 
          content_tag(:tr) do 
            fields_values.each do |value|
              content_tag(:td, value)
            end
          end
        end
      end
      content_tag(:hr)
    end    
  end

end
