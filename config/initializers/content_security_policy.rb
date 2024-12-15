
=begin
# config/initializers/content_security_policy.rb
Rails.application.config.content_security_policy do |policy|
  # より柔軟なCSP設定
  policy.default_src :self
  
  # 信頼できるCDNからのスクリプトを許可
  policy.script_src :self, 
                    :unsafe_inline, 
                    'https://cdn.jsdelivr.net', 
                    'https://cdnjs.cloudflare.com'
  
  # 外部スタイルシートも許可
  policy.style_src :self, 
                   :unsafe_inline, 
                   'https://cdn.jsdelivr.net'
  
  # 画像の許可ドメインを拡大
  policy.img_src :self, 
                 'https://example.com', 
                 'https://placekitten.com'
  
  # フォントリソースの許可
  policy.font_src :self, 
                  'https://fonts.gstatic.com', 
                  'https://fonts.googleapis.com'
end

=end

=begin cspエラー発生用
Rails.application.config.content_security_policy do |policy|
  # デフォルトではすべてのリソースをブロック
  policy.default_src :none
  
  # スクリプトは自身のオリジンからのみ許可
  policy.script_src :self
  
  # スタイルシートは自身のオリジンから
  policy.style_src :self
  
  # 画像は自身のオリジンと特定の外部ドメインから
  policy.img_src :self, 'https://example.com'
  
  # フォントは自身のオリジンから
  policy.font_src :self
  
  # フレームは許可しない
  policy.frame_src :none
  
  # インラインスクリプトは無効化
  policy.script_src :self, :unsafe_inline
end


# CSPヘッダーを有効化
Rails.application.config.content_security_policy_nonce_generator = -> request { SecureRandom.base64(16) }
Rails.application.config.content_security_policy_nonce_directives = %w(script-src)
=end



# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy
# For further information see the following documentation
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

# Rails.application.config.content_security_policy do |policy|
#   policy.default_src :self, :https
#   policy.font_src    :self, :https, :data
#   policy.img_src     :self, :https, :data
#   policy.object_src  :none
#   policy.script_src  :self, :https
#   policy.style_src   :self, :https
#   # If you are using webpack-dev-server then specify webpack-dev-server host
#   policy.connect_src :self, :https, "http://localhost:3035", "ws://localhost:3035" if Rails.env.development?

#   # Specify URI for violation reports
#   # policy.report_uri "/csp-violation-report-endpoint"
# end

# If you are using UJS then enable automatic nonce generation
# Rails.application.config.content_security_policy_nonce_generator = -> request { SecureRandom.base64(16) }

# Set the nonce only to specific directives
# Rails.application.config.content_security_policy_nonce_directives = %w(script-src)

# Report CSP violations to a specified URI
# For further information see the following documentation:
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy-Report-Only
# Rails.application.config.content_security_policy_report_only = true
