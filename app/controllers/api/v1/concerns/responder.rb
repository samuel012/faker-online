module Api::V1::Concerns
  module Responder
    def json_response(object, status = :ok)
      render json: object, status: status
    end
  end
end