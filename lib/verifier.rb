require 'net/http'
require 'json'

module CheckWhatsApp
  class Verifier
    TWILIO_API_URL = 'https://api.twilio.com/your-api-endpoint'

    def initialize(account_sid, auth_token)
      @account_sid = account_sid
      @auth_token = auth_token
    end

    def check_number(phone_number)
      uri = URI("#{TWILIO_API_URL}/phone_numbers/#{phone_number}")
      req = Net::HTTP::Get.new(uri)
      req.basic_auth(@account_sid, @auth_token)

      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end

      case res
      when Net::HTTPSuccess
        data = JSON.parse(res.body)
        return data["whatsapp"] ? "Número possui WhatsApp" : "Número não possui WhatsApp"
      else
        return "Erro na verificação"
      end
    end
  end
end
