require 'omniauth'
require 'omniauth-saml'

# セキュリティ警告を抑制（開発環境のみ推奨）
OmniAuth.config.silence_get_warning = true

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, 
      ENV['GOOGLE_CLIENT_ID'], 
      ENV['GOOGLE_CLIENT_SECRET'],
      {
        scope: 'email,profile',
        prompt: 'select_account',

        #scope: 'email,profile',
        #prompt: 'select_account',
        image_aspect_ratio: 'square',
        image_size: 50,
        #access_type: 'offline',
        #redirect_uri: 'http://localhost:3000/auth/google_oauth2/callback', # 明示的に指定
        redirect_uri: 'http://127.0.0.1:3000/auth/google_oauth2/callback',
        name: 'google_oauth2'  # この名前をgoogle_oauth2に変更
      }

    #SAML用
    provider :saml,
    issuer: "rails-app",
    assertion_consumer_service_url: "http://127.0.0.1:3000/auth/saml/callback",
    idp_sso_target_url: "http://localhost:8080/realms/rails-dev/protocol/saml",
    idp_cert: "-----BEGIN CERTIFICATE-----\n MIICoTCCAYkCBgGUfiH95jANBgkqhkiG9w0BAQsFADAUMRIwEAYDVQQDDAlyYWlscy1kZXYwHhcNMjUwMTE5MTAzNDA0WhcNMzUwMTE5MTAzNTQ0WjAUMRIwEAYDVQQDDAlyYWlscy1kZXYwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCnp1D+huyjN92ZBmSYvIictsjtLDVUKvdPGTmeavHCl7O9RHFjG0KzGXzSFBEbzM1mzSJSifsE5tcyBrr8PFeWPWCZ9pJPba7nYARb/3TwANoni//43v7eWqwerw1yWooddCWM9u92cbpkswcTYnrH9AgcUwqrWsENWwQlSh1bZBsQVXtHkLpDJ20JVzHpwjWCox6bNowTO12NWanhn1xP8TKzQpfBePNHBExCc5qpahdShoBJtnujOLSYYPsHNOX7wys1Xwfm8pqXjiSLHtNp+Z4whRqxN5AbvgvR6MiohRJ0ZrJo8UWx0KoS0rDh93dzK/GO12Bcfh7PBZ5ziJXTAgMBAAEwDQYJKoZIhvcNAQELBQADggEBADzjxdiLY8wG9Q2ipsn32+WA5NFhTnKfljAectWf9jof8aevl+RMkBs6gkXRmY8QGTlb8bSaZ8WFM9pl3SElsLbm0qezPFslS08zI1XLQxtbMlBDkFKYAwf/HRDv86MIlfqNZY8vgS/oOJOTZP1kS6BDvnn2u3oOFCoidySHd2yLvna9X1xTvxGZMmH+ZQdmOGKachlmyQmn56QlY81JBnENPc2KMiL57Fd+XlR3D0qfP73qFvzWY4XUDbhd8J81ijxW2wV0JAoG0+LBMQq87gz7a6UUCM26lxjug5tniEumOb/ZjZ33cYNlrJav/0to8OqueLwAsSRrJ+ep9onYqD8= \n-----END CERTIFICATE-----", # Keycloakの証明書
    name_identifier_format: "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress",
    skip_validation: true,  # 証明書検証をスキップ
    security: {
      allow_unsolicited: true,          
      want_response_signed: false,
      authn_requests_signed: false,
      want_assertions_signed: false
    }
=begin
    idp_metadata_parser = OneLogin::RubySaml::IdpMetadataParser.new
  
    begin
      # メタデータを直接設定する方法
      provider :saml,
        issuer: "rails-app",
        assertion_consumer_service_url: "http://localhost:3000/auth/saml/callback",
        sp_entity_id: "rails-app",
        # IdPのURLを直接指定
        idp_sso_target_url: "http://localhost:8080/realms/rails-dev/protocol/saml",
        idp_slo_target_url: "http://localhost:8080/realms/rails-dev/protocol/saml",
        name_identifier_format: "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress",
        request_path: "/auth/saml",
        callback_path: "/auth/saml/callback",
        security: {
          authn_requests_signed: false,
          logout_requests_signed: false,
          logout_responses_signed: false,
          want_assertions_signed: false,
          want_assertions_encrypted: false,
          want_name_id: false,
          metadata_signed: false,
          embed_sign: false
        }
  
      # メタデータのデバッグ出力
      Rails.logger.debug "SAML configuration completed"
    rescue StandardError => e
      Rails.logger.error "Failed to configure SAML: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
    end

    idp_metadata_parser = OneLogin::RubySaml::IdpMetadataParser.new
    metadata = idp_metadata_parser.parse_remote_to_hash(
      "http://localhost:8080/realms/rails-dev/protocol/saml/descriptor",
      true # 開発環境では証明書の検証をスキップ
    )
    provider :saml,
      issuer: 'rails-app',
      assertion_consumer_service_url: 'http://127.0.0.1:3000/auth/saml/callback',
      #idp_sso_target_url: metadata[:idp_sso_target_url],
      #idp_cert_fingerprint: metadata[:idp_cert_fingerprint],
      #name_identifier_format: "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress",
      security: {
        authn_requests_signed: false,
        want_assertions_signed: true,
        want_assertions_encrypted: false,
        metadata_signed: false
      },
      attribute_statements: {
        email: ['email'],
        name: ['name'],
        first_name: ['first_name'],
        last_name: ['last_name']
      }

    idp_metadata_parser = OneLogin::RubySaml::IdpMetadataParser.new
    metadata = idp_metadata_parser.parse_remote_to_hash(
      "http://localhost:8080/realms/rails-dev/protocol/saml/descriptor",
      true #証明書の検証をスキップ
    )
    provider :saml, metadata.merge(
      issuer: "rails-app",
      assertion_consumer_service_url: "http://127.0.0.1:3000/saml/callback"
    )

    #idp_metadata_parser = OneLogin::RubySaml::IdpMetadataParser.new
    #idp_metadata = idp_metadata_parser.parse_remote_to_hash("http://localhost:8080/realms/rails-dev/protocol/saml/descriptor", true)  # trueでSSL検証をスキップ
    provider :saml,
      #issuer: "rails-saml",
      issuer: "rails-app",
      assertion_consumer_service_url: "http://127.0.0.1:3000/saml/callback",
      idp_cert_fingerprint_algorithm: "SHA1",
      name_identifier_format: "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress",
      #idp_sso_target_url: idp_metadata[:idp_sso_target_url],
      idp_sso_service_url: '',
      idp_sso_target_url: 'http://localhost:8080/realms/rails-dev/protocol/saml'
      #idp_cert: idp_metadata[:idp_cert]
=end
  end

# Development環境での設定
if Rails.env.development?
  OmniAuth.config.allowed_request_methods = [:post, :get]
  # SSL証明書の検証を無効化（開発環境のみ）
  OmniAuth.config.full_host = 'http://127.0.0.1:3000'

  OmniAuth.config.logger = Rails.logger
  #OmniAuth.config.debug = true
  OmniAuth.config.allowed_request_methods = [:post, :get]
  OmniAuth.config.silence_get_warning = true
end