class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user)
    #room内のmessagesを全て取得。
    #N+１問題解消のため、user情報をまとめて取得する
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    #生成したインスタンスにprivateメソッドの結果を代入
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
      render :index
    end
  end

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
    #messageテーブルから送信フォーム内のデータ(conten)を取り出して
    #roomテーブルに紐付いているcurrent_user.idを連結させる
  end

end
