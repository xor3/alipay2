# frozen_string_literal: true

module Alipay
  module Service
    module Auth

      USER_INFO_AUTH_REQUIRED = [
        :scopes,
        :state
      ]
      def user_info_auth(params = {}, options = {})
        params = { scopes: 'auth_user', state: Alipay::Utils.generate_batch_no }.merge(params)
        Alipay::Utils.check_params(params, USER_INFO_AUTH_REQUIRED)

        options.merge!(method: 'alipay.user.info.auth')
        request_uri(params, options)
      end

      def user_info_auth_params(params = {}, options = {})
        params = { scopes: 'auth_user', state: Alipay::Utils.generate_batch_no }.merge(params)
        Alipay::Utils.check_params(params, USER_INFO_AUTH_REQUIRED)

        options.merge!(method: 'alipay.user.info.auth')
        process_params(params, options)
      end

      def open_auth_sdk_code_get_params(params = {}, options = {})
        options.merge!(apiname: 'com.alipay.account.auth',
                       method: 'alipay.open.auth.sdk.code.get',
                       app_id: Alipay.config.appid,
                       app_name: 'mc',
                       biz_type: 'openservice',
                       pid: Alipay.config.pid,
                       product_id: 'APP_FAST_LOGIN',
                       scope: 'kuaijie',
                       target_id: params[:target_id] || Alipay::Utils.generate_batch_no,
                       auth_type: 'AUTHACCOUNT'
        )
        options.merge! sign_params(options)
        URI.encode_www_form(options)
      end

      def oauth_url
        params = {
          app_id: Alipay.config.appid,
          redirect_uri: Alipay.config.oauth_callback
        }

        url = URI(Alipay.config.oauth_url)
        url.query = URI.encode_www_form(params)
        url.to_s
      end

    end
  end
end
