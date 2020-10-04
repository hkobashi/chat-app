class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    #生成したインスタンスにprivateメソッドの結果を代入
    if @message.save
      redirect_to room_messages_path(@room)
    else
      render :index
    end
  end

  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
    #messageテーブルから送信フォーム内のデータ(conten)を取り出して
    #roomテーブルに紐付いているcurrent_user.idを連結させる
  end

end
