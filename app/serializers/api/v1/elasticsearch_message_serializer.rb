class Api::V1::ElasticsearchMessageSerializer < ActiveModel::Serializer
    attributes :id, :message_number, :body
end
  