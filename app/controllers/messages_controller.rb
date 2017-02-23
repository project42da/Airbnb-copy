class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact

  def index
    if current_user == @contact.sender || current_user == @contact.recipient
      # 접속중인 유저가 contact.sender, recipient 둘중에 하나일 경우
      # 다른사람은 접속중인 유저가 sender일 때는 recipient, 반대일때는 sender
      @other = current_user == @contact.sender ? @contact.recipient : @contact.sender
      @messages = @contact.messages.order("created_at DESC")
    else
      # 접속중인 유저가 contact.sender, recipient가 아닐경우
      redirect_to contacts_path, alert: "권한이 없습니다."
    end
  end

  def create
    @message = @contact.messages.new(messages_params)
    @messages = @contact.messages.order("created_at DESC")

    if @message.save
      respond_to do |format|
        format.js
      end
    end
    
  end

  private
  
  def set_contact
    @contact = Contact.find(params[:contact_id])
  end

  def messages_params
    params.require(:message).permit(:content, :user_id)
  end

end
