# spec/controllers/ses_records_controller_spec.rb
require 'rails_helper'

RSpec.describe SesRecordsController, type: :controller do
  describe 'POST #transform' do
    let(:valid_payload) do
      {
        "Records" => [
          {
            "eventVersion" => "1.0",
            "ses" => {
              "receipt" => {
                "timestamp" => "2015-09-11T20:32:33.936Z",
                "processingTimeMillis" => 222,
                "recipients" => [ "recipient@example.com" ],
                "spamVerdict" => { "status" => "PASS" },
                "virusVerdict" => { "status" => "PASS" },
                "spfVerdict" => { "status" => "PASS" },
                "dkimVerdict" => { "status" => "PASS" },
                "dmarcVerdict" => { "status" => "PASS" }
              },
              "mail" => {
                "timestamp" => "2015-09-11T20:32:33.936Z",
                "source" => "sender@example.com",
                "destination" => [ "recipient@example.com" ]
              }
            }
          }
        ]
      }
    end

    let(:invalid_payload) do
      { "invalid_key" => "invalid_value" }
    end

    context 'with valid payload' do
      it 'returns a successful response' do
        post :transform, params: valid_payload
        expect(response).to have_http_status(:success)
      end

      it 'returns the correct transformed JSON' do
        post :transform, params: valid_payload
        json_response = JSON.parse(response.body)
        expect(json_response).to eq({
          "spam" => true,
          "virus" => true,
          "dns" => true,
          "mes" => "September",
          "retrasado" => false,
          "emisor" => "sender",
          "receptor" => [ "recipient" ]
        })
      end
    end

    context 'with invalid payload' do
      it 'returns an unprocessable_entity status' do
        post :transform, params: invalid_payload
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        post :transform, params: invalid_payload
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to be_present
      end
    end
  end
end
