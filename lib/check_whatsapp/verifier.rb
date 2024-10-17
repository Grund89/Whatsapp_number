require 'net/http'
require 'json'

module CheckWhatsApp
  class Verifier
    ZAPI_API_URL = 'https://api.z-api.io/instances/3D6E48EB6E3900C780172272D360C213/token/6775DEBE21946BD9CBD6E017/send-text'

    def initialize(api_token)
      @api_token = api_token
    end

    def check_number(phone_number)
      uri = URI("#{ZAPI_API_URL}/#{phone_number}/iswhatsapp")
      req = Net::HTTP::Get.new(uri)
      req['Authorization'] = "Bearer #{@api_token}"

      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end

      # Exibe a resposta completa para depuração
      puts "Resposta da API: #{res.body}"

      if res.is_a?(Net::HTTPSuccess)
        data = JSON.parse(res.body)

        # Verifica se a estrutura esperada está presente
        if data && data["result"] && data["result"]["isWhatsapp"]
          return data["result"]["isWhatsapp"] ? "Número possui WhatsApp" : "Número não possui WhatsApp"
        else
          return "Erro: Resposta da API não contém os dados esperados."
        end
      else
        return "Erro na verificação: #{res.message}"
      end
    end
  end
end
