📦 SES JSON Transformer API
🚀 Project Overview
This Ruby on Rails API project transforms an incoming SES (Simple Email Service) JSON payload into a cleaner, more structured JSON response.

Key Features:
Accepts SES JSON payloads via a POST request.
Transforms and maps data into a structured JSON format.
Includes robust error handling for invalid payloads.
Tested using RSpec to ensure reliability.
🛠️ Tech Stack
Framework: Ruby on Rails 7.2.1
Language: Ruby 3.3.0
Testing: RSpec
API Tools: Postman
📥 Setup and Installation
1. Clone the Repository

git clone https://github.com/yourusername/ses_json_transformer.git
cd ses_json_transformer
2. Install Dependencies
Make sure all gems are installed:

bundle install
3. Setup the Database
rails db:setup
4. Run the Server
Start the Rails server:

rails server
The server will be available at:


http://localhost:3000
📡 API Endpoint Documentation
Transform SES JSON Payload
URL: /transform
Method: POST
Content-Type: application/json

Request Body Example
json
{
  "Records": [
    {
      "eventVersion": "1.0",
      "ses": {
        "receipt": {
          "timestamp": "2015-09-11T20:32:33.936Z",
          "processingTimeMillis": 222,
          "recipients": ["recipient@example.com"],
          "spamVerdict": {"status": "PASS"},
          "virusVerdict": {"status": "PASS"},
          "spfVerdict": {"status": "PASS"},
          "dkimVerdict": {"status": "PASS"},
          "dmarcVerdict": {"status": "PASS"}
        },
        "mail": {
          "timestamp": "2015-09-11T20:32:33.936Z",
          "source": "sender@example.com",
          "destination": ["recipient@example.com"]
        }
      }
    }
  ]
}
Response Example
json
{
  "spam": true,
  "virus": true,
  "dns": true,
  "mes": "September",
  "retrasado": false,
  "emisor": "sender",
  "receptor": ["recipient"]
}
Error Response Example
json
{
  "error": "Missing required parameters"
}
Status Codes
200 OK – Successful Transformation
422 Unprocessable Entity – Invalid Payload

🧪 Running Tests

1. Run RSpec Tests
bundle exec rspec
2. Test Specific File
bundle exec rspec spec/controllers/ses_records_controller_spec.rb

Expected output:
4 examples, 0 failures
