class Public::ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save!
      ContactMailer.send_mail(@contact).deliver
      redirect_to done_contacts_path
    else
      render :new
    end
  end

  def done
  end


    private

    def contact_params
      params.require(:contact).permit(:name, :email, :contact_message)
    end

end
