class SesRecordsController < ApplicationController
  def transform
    input_data = params.to_unsafe_h # Access raw params safely
    ses_record = SesRecord.new(input_data)
    render json: ses_record.to_h
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
