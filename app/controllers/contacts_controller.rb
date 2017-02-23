class ContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @contacts = Contact.involving(current_user)
  end

  def create
    if Contact.between(params[:sender_id], params[:recipient_id]).present?
      # sender, recipient between이 존재하는가? between은 where로 contact를 찾는 메서드(배열반환)
      @contact = Contact.between(params[:sender_id], params[:recipient_id]).first
    else
      @contact = Contact.create(contacts_params)
    end

    redirect_to contact_messages_path(@contact)
  end

  private
  
  def contacts_params
    params.permit(:sender_id, :recipient_id)
  end

end
