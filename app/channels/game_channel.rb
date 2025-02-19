class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_of_life"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
