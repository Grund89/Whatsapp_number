require_relative '../lib/check_whatsapp/verifier'

# Atribuindo apenas o token da API
verifier = CheckWhatsApp::Verifier.new(ARGV[0])

# Verificando o número passado como argumento
puts verifier.check_number(ARGV[1])
