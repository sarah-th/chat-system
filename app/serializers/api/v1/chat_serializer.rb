class Api::V1::ChatSerializer < ActiveModel::Serializer
  attributes :chat_number, :messages_count, :created_at
end
