class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_#{params['room_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Chat.create(user_id: data['curent_user_id'], room_id: params['room_id'], content: data['data'])
    ActionCable.server.broadcast "chat_channel_#{params['room_id']}", data
  end
end
