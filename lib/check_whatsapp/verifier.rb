require 'net/http'
require 'json'

module CheckWhatsApp
  class Verifier
    Z_API_URL = 'https://api.z-api.io/instances/seu_id_da_instance/token/seu_token_aqui/contacts'

    def initialize(api_token)
      @api_token = api_token
    end

    def check_number(phone_number)
      uri = URI("#{Z_API_URL}/#{phone_number}/iswhatsapp")
      req = Net::HTTP::Get.new(uri)

      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end

      # Verifique se a resposta é válida e se o corpo pode ser convertido em JSON
      if res.is_a?(Net::HTTPSuccess)
        data = JSON.parse(res.body)

        # Verifique se o campo esperado está presente no corpo da resposta
        if data && data["isWhatsapp"]
          return data["isWhatsapp"] ? "Número possui WhatsApp" : "Número não possui WhatsApp"
        else
          return "Erro: Resposta da API não contém os dados esperados."
        end
      else
        return "Erro na verificação: #{res.message}"
      end
    end
  end
end
