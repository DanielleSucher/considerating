module IntegrationSpecHelper
  def login_with_omniauth(provider = :twitter)
    visit "/auth/#{provider}"
  end
end

	# Omniauth mock setup
	Capybara.default_host = 'http://example.org'

	OmniAuth.config.test_mode = true
	OmniAuth.config.add_mock(:twitter, {
	  :uid => '12345',
	  :name => 'zapnap'
	})