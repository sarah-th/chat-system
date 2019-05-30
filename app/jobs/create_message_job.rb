class CreateMessageJob < ApplicationJob
  queue_as :default

  def perform(chat_id, body)
    message = Message.new(chat_id: chat_id, body: body)
    message.save
  end
end
