require 'net/http'
require 'json'
require 'cgi'

module CheckWhatsApp
  class Verifier
    TWILIO_API_URL = 'https://lookups.twilio.com/v2/PhoneNumbers'

    def initialize(account_sid, auth_token)
      @account_sid = account_sid
      @auth_token = auth_token
    end

    def check_number(phone_number)
      encoded_phone_number = CGI.escape(phone_number)
      uri = URI("#{TWILIO_API_URL}/#{encoded_phone_number}")
      response = make_request(uri)

      case response
      when Net::HTTPSuccess
        data = JSON.parse(response.body)
        return has_whatsapp?(data) ? "Número possui WhatsApp" : "Número não possui WhatsApp"
      else
        return "Erro na verificação: #{response.message}"
      end
    end

    private

    def make_request(uri)
      req = Net::HTTP::Get.new(uri)
      req.basic_auth(@account_sid, @auth_token)

      Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end
    end

    def has_whatsapp?(data)
      data.key?("capabilities") && data["capabilities"]["sms"]
    end
  end
end
