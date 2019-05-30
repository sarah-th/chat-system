class Api::V1::MessageSerializer < ActiveModel::Serializer
  attributes :message_number, :body, :created_at
end
