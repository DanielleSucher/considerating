module IntegrationSpecHelper
  def login_with_omniauth(provider = :google_oauth2)
    visit "/auth/#{provider}"
  end
end