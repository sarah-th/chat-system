Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :applications, param: :token do
        resources :chats, param: :chat_number, shallow: true
      end

      resources :applications, param: :token, only: [] do
        resources :chats, param: :number, only: [] do
          resources :messages
        end
      end
      
    end
  end
end
