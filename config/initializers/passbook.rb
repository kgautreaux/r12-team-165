Passbook.configure do |passbook|
  # Path to your cert.p12 file
  passbook.p12_cert = Mconf[Rails.env][:p12_cert_path]
  # Path to your wwdc_cert.pem file
  passbook.wwdc_cert = Mconf[Rails.env][:wwdc_cert_path]
  # Password for your certificate
  passbook.p12_password = Mconf[Rails.env][:p12_cert_password]
end