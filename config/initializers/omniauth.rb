Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, '496909690695.apps.googleusercontent.com', '784i1MUyj22KEmPsVtFdJLgY', {access_type: 'online', approval_prompt: '', :scope => 'https://www.googleapis.com/auth/userinfo.profile', :client_options => {:ssl => {:ca_path => "certs/cacert.pem"}}}
end