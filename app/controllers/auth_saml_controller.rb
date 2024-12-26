class AuthSamlController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:acs]

  def saml
  end

  def sso
    settings = saml_settings
    request = OneLogin::RubySaml::Authrequest.new
    redirect_to(request.create(settings))
  end

  def acs
    response = OneLogin::RubySaml::Response.new(params[:SAMLResponse], settings: saml_settings)

    if response.is_valid?
      session[:user_id] = response.nameid
      redirect_to root_path, notice: 'Successfully authenticated'
    else
      redirect_to root_path, alert: 'Failed to authenticate'
    end
  end

  def metadata
    settings = saml_settings
    meta = OneLogin::RubySaml::Metadata.new
    render xml: meta.generate(settings), content_type: 'application/samlmetadata+xml'
  end

  def delete

  end
  
  private

  def saml_settings
    settings = OneLogin::RubySaml::Settings.new

    settings.assertion_consumer_service_url = saml_acs_url
    settings.sp_entity_id                   = saml_metadata_url
    settings.idp_entity_id                  = 'https://app.onelogin.com/saml/metadata/123456'
    settings.idp_sso_target_url             = 'https://app.onelogin.com/trust/saml2/http-post/sso/123456'
    settings.idp_cert_fingerprint           = '1234567890123456789012345678901234567890'
    settings.name_identifier_format         = 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress'

    settings
  end
end