class CreateChatJob < ApplicationJob
  queue_as :default

  def perform(application_id)
    chat = Chat.new(application_id: application_id)
    chat.save
  end

end
