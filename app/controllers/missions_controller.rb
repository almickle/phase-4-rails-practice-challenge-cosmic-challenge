class MissionsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  
  # POST /missions
  def create
    mission = Mission.create!(mission_params)
    render json: Planet.find(params[:planet_id]), status: :created
  end

  private

    # Only allow a list of trusted parameters through.
    def mission_params
      params.permit(:id, :name, :scientist_id, :planet_id)
    end

    def render_unprocessable_entity_response(invalid)
      render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
