class Api::V1::MessagesController < ApiController
    before_action :set_application

    def index
        chat = Chat.find_by(application: @application, chat_number: message_params[:chat_number])
        return render json: { success: false, message: 'Chat not found' }, status: 404 unless chat.present?
        if params[:query].present?
            bool_params = {
                must: {
                    multi_match: {
                        query: params[:query],
                        fields: ["body"],
                        fuzziness: "0",
                        zero_terms_query: "all",
                        prefix_length: 3,
                        operator: "and"
                    }
                }
            }

            search_params = {
                query: {
                    bool: bool_params
                },
                sort: [
                    "_score"
                ],
            }
            messages = chat.messages.search(search_params).records
        else
            messages = chat.messages
        end
        
        return render json: { success: true, data: ActiveModel::SerializableResource.new(messages, each_serializer: Api::V1::MessageSerializer) }, status: 200
    end


    def create
        return render json: { success: false, message: 'Message body is required' }, status: 400 unless message_params[:body].present?
        
        chat = Chat.find_by(application: @application, chat_number: message_params[:chat_number])
        return render json: { success: false, message: 'Chat not found' }, status: 404 unless chat.present?

        # queue the job
        CreateMessageJob.perform_later chat.id, message_params[:body]

        return render json: { success: true, message: {message_number: chat.messages.last.message_number + 1, body: message_params[:body]} }, status: 200
    end

    def set_application
        @application = Application.find_by(token: message_params[:application_token])
        return render json: { success: false, message: 'Invalid application token' }, status: 404 unless @application.present?
    end

    private
    def message_params
        params.permit(:application_token, :chat_number, :body)
    end
    
end
