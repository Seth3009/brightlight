class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy, :mark_read]

  # GET /messages
  # GET /messages.json
  def index
    respond_to do |format|
      format.html { @messages = Message.includes(:creator).for(current_user) } # from application_controller
      format.json { @messages = Message.includes(:creator).for(params[:id]) rescue [] }  
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was deleted.' }
      # format.js { head: no_content }
      format.json { head :no_content }
    end
  end

  # POST /message/1/mark_read
  def mark_read
    @message.message_recipients.where(recipient_id: params["user_id"]).update_all is_read: true
    respond_to do |format|
      format.json { render json: {unread: Message.unread(current_user).count} }
    end
  end

  # POST /messages/mark
  def mark
    if params[:all] == "yes"
      MessageRecipient.where(recipient_id: current_user.id).update_all is_read: params[:read]
    else
      @messages = params[:mark].map {|id,on| id}
      MessageRecipient.where(message_id: @messages).where(recipient_id: current_user.id).update_all is_read: params[:read]
    end
    respond_to do |format|
      format.html { redirect_to messages_path }
      format.js
    end
  end

  # DELETE /messages
  def delete 
    @messages = Message.where(id: params[:merge].map(&:id))
    @messages.destroy_all
    respond_to do |format|
      format.js { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:subject, :creator_id, :body, :parent_id, :expiry_date, :is_reminder, :next_remind_date, :remind_frequency_id, :tags, :folder_id)
    end
end
