#!/usr/bin/env ruby

require "check_whatsapp"

if ARGV.length != 3
  puts "Uso: check_whatsapp ACCOUNT_SID AUTH_TOKEN NUMERO_TELEFONE"
  exit
end

account_sid = ARGV[0]
auth_token = ARGV[1]
phone_number = ARGV[2]

verifier = CheckWhatsApp::Verifier.new(account_sid, auth_token)
puts verifier.check_number(phone_number)
