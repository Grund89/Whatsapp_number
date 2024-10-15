require_relative '../lib/check_whatsapp/verifier'

# Inicializa o Verifier com Account SID e Auth Token
verifier = CheckWhatsApp::Verifier.new(ARGV[0], ARGV[1])

# Passa o número de telefone para o método check_number
phone_number = ARGV[2]
resultado = verifier.check_number(phone_number)

# Exibe o resultado
puts resultado
