Devise.setup do |config|
  config.mailer_sender = "please-change-me-at-config-initializers-devise@example.com"

  require "devise/orm/active_record"

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.sign_out_via = :delete

  config.password_length = 6..128
  config.reset_password_within = 6.hours

  # Hotwire/Turbo configurations.
  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other

  google_client_id = Utils.env_or_credential "oauth.google_client_id", ""
  google_client_secret = Utils.env_or_credential "oauth.google_client_secret", ""
  config.omniauth :google_oauth2, google_client_id, google_client_secret
end
