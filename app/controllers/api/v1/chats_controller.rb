class Api::V1::ChatsController < ApiController
    before_action :set_application

    def index
        chats = @application.chats.order(chat_number: :desc)

        return render json: { success: true, chats: ActiveModel::SerializableResource.new(chats, each_serializer: Api::V1::ChatSerializer) }, status: 200
    end
    
    def create
        # queue the job
        CreateChatJob.perform_later @application.id

        return render json: { success: true, chat: {chat_number: @application.chats.last.chat_number + 1 }}, status: 200
    end

    def set_application
        @application = Application.find_by(token: chat_params[:application_token])
        return render json: { success: false, message: 'Invalid application token' }, status: 404 unless @application.present?
    end

    private
    def chat_params
        params.permit(:application_token)
    end
    
end
