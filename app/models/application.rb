class Application < ApplicationRecord
    has_secure_token
    has_many :chats
    validates_presence_of :name

    def chats_count
        Rails.cache.fetch([cache_key, __method__]) do
          self.chats.count
        end
    end
end
