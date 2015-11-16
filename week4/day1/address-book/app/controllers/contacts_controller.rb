class ContactsController < ApplicationController
  
  def index
    @contacts = Contact.all.order("name ASC")
    render "index"
  end

  def add_contact
    @atributes = { name: "normal", address: "normal", phoneNumber: "normal", email: "normal"}
    @fail_form = false
    render "new"    
  end

  def create
    def checker(data)
      return data.map {|key, value| return key if value == nil}
    end
    if (params[:name] != nil || params[:address] != nil)
      contact = Contact.new(
        :name => params[:contact][:name],
        :address => params[:contact][:address],
        :phoneNumber => params[:contact][:phoneNumber],
        :email => params[:contact][:email])
      contact.save
      redirect_to("/contacts")
    else
      arr_key_wrongs = checker(params[contact])
      
      arr_key_wrongs.each {|key| @atributes[key] = "fail"}
      @fail_form = true
      render "new"
    end
  end

  def info
    name = params[:name]
    @contact = Contact.find_by(name: name)
    render "info"
  end
end
