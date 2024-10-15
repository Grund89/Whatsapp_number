require 'net/http'
require 'json'

module CheckWhatsApp
  class Verifier
    TWILIO_API_URL = 'https://api.twilio.com/2010-04-01/Accounts' # Exemplo de endpoint

    def initialize(account_sid, auth_token)
      @account_sid = account_sid
      @auth_token = auth_token
    end

    def check_number(phone_number)
      # Imprime o diretório atual
      puts "Diretório atual: #{Dir.pwd}"

      uri = URI("#{TWILIO_API_URL}/#{@account_sid}/IncomingPhoneNumbers.json")
      req = Net::HTTP::Get.new(uri)
      req.basic_auth(@account_sid, @auth_token)

      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end

      case res
      when Net::HTTPSuccess
        data = JSON.parse(res.body)
        # Aqui você deve implementar a lógica para verificar se o número possui WhatsApp
        # Isso depende da API que você está usando. Vou assumir que há uma chave "whatsapp" no JSON.
        return data["whatsapp"] ? "Número possui WhatsApp" : "Número não possui WhatsApp"
      else
        return "Erro na verificação: #{res.message}"
      end
    end
  end
end
