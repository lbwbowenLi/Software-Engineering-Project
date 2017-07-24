OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  configure do |config|
    config.path_prefix = '/auth'
  end
  provider :facebook, '198856547204917', '1aa767c5e0cbb31d4ea3177a8dd84860', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
  provider :google_oauth2, '275465204771-jib71abfvc0khlpfgao8u22bmcp16a5r.apps.googleusercontent.com', '2tSavXkL9yJ6J__SaSbSERN2', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
