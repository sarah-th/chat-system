class Message < ApplicationRecord
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name "messages-#{Rails.env}"

    belongs_to :chat
    validates_presence_of :body
    auto_increment :message_number, scope: [:chat_id]
 
    #  for elasticsearch
    settings analysis: {
        blocks: {read_only: false},
        filter: {
            monograms_filter: {
                type: "edge_ngram",
                min_gram: 1,
                max_gram: 10
            }
        },
        analyzer: {
            monograms: {
                type: "custom",
                tokenizer: "standard",
                filter: ["lowercase", "monograms_filter"]

            }
        }
    } do
        mappings dynamic: false do
            indexes :body, type: :text, analyzer: :monograms, search_analyzer: :standard
        end
    end

    def as_indexed_json(options={})
        Api::V1::ElasticsearchMessageSerializer.new(self, root: false).as_json
    end
    
end
