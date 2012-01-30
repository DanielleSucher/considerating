module IntegrationSpecHelper
  def login_with_omniauth(provider = :twitter)
    visit "/auth/#{provider}"
  end
end