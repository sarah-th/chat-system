class Api::V1::ApplicationsController < ApiController
    
    def create
        application = Application.new(application_params)
        return render json: { success: false, message: application.errors.full_messages[0] }, status: 400 unless application.save

        return render json: { success: true, application: Api::V1::ApplicationSerializer.new(application) }, status: 200
    end

    def update
        application = Application.find_by(token: params[:token])
        return render json: { success: false, message: 'Invalid application token' }, status: 404 unless application.present?
        return render json: { success: false, message: application.errors.full_messages[0] }, status: 400 unless application.update(application_params)

        return render json: { success: true, application: Api::V1::ApplicationSerializer.new(application) }, status: 200
    end

    def show
        application = Application.find_by(token: params[:token])
        return render json: { success: false, message: 'Invalid application token' }, status: 404 unless application.present?

        return render json: { success: true, application: Api::V1::ApplicationSerializer.new(application) }, status: 200
    end

    private
    def application_params
        params.permit(:name)
    end
    
end
