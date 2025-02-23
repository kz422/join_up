# app/channels/meeting_channel.rb
class MeetingChannel < ApplicationCable::Channel
  def subscribed
    # 接続時に受け取ったパラメータ meeting_id を購読
    stream_from "meeting_#{params[:meeting_id]}"
  end

  def unsubscribed
    # 何も書かなくてもOK
  end
end
