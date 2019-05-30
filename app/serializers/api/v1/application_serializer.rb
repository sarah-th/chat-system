class Api::V1::ApplicationSerializer < ActiveModel::Serializer
  attributes :token, :name, :chats_count, :created_at
  
end
