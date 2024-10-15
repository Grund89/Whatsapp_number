require_relative 'check_whatsapp/verifier'

# Passe os parâmetros para o Verifier
verifier = CheckWhatsApp::Verifier.new(ARGV[0], ARGV[1], ARGV[2])
verifier.check_number
