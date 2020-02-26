class ChatController < ApplicationController
   before_action :authenticate_user!

  def show
    # チャット（メッセージ）一覧を取得
    @messages = Chat.all
  end

end
