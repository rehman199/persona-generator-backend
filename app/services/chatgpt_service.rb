class ChatgptService
	include HTTParty

	def initialize(message)
		api_key = Rails.application.credentials.chatgpt_api_key

		@message = message
		@url = "https://api.openai.com/v1/chat/completions"

		@options = {
			headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{api_key}"
      }
		}
	end

	def call
		body = { model: "gpt-3.5-turbo", messages: [{ role: "user", content: @message }] }
		response = HTTParty.post(@url, body: body.to_json, headers: @options[:headers], timeout: 20)
		raise response['error']['message'] unless response.code == 200

		response['choices'][0]['message']['content']
	end

	def self.get_response(prompt)
		new(prompt).call
	end
end