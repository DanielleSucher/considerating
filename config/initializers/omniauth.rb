# live site
Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, '----.apps.googleusercontent.com', '------', {access_type: 'online', approval_prompt: '', :scope => 'https://www.googleapis.com/auth/userinfo.profile', client_options: {ssl: {ca_file: Rails.root.join('lib/assets/cacert.pem').to_s}}}
end



# localhost
#Rails.application.config.middleware.use OmniAuth::Builder do
#     provider :google_oauth2, '------.apps.googleusercontent.com', '-------', {access_type: 'online', approval_prompt: '', :scope => 'https://www.googleapis.com/auth/userinfo.profile', client_options: {ssl: {ca_file: Rails.root.join('lib/assets/cacert.pem').to_s}}}
#end