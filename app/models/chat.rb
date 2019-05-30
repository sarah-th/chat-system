class Chat < ApplicationRecord
    belongs_to :application
    has_many :messages

    auto_increment :chat_number, scope: [:application_token]

    def messages_count
        Rails.cache.fetch([cache_key, __method__]) do
          self.messages.count
        end
    end
end
