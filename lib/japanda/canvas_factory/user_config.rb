module CanvasFactory
  class UserConfig
    attr_accessor :email_prefix, :password, :short_name, :terms_of_use, :send_confirmation,
                  :force_validations, :role_id, :email_id

    def initialize(opts = {})
      @email_prefix = opts[:email_prefix] || 'catauto'
      @password = opts[:password] || 'Testing01'
      @short_name = opts[:short_name] || 'cat auto'
      @terms_of_use = opts[:terms_of_use] || '1'
      @send_confirmation = opts[:send_confirmation] || true
      @force_validations = opts[:force_validations] || true
      @role_id = opts[:role_id] || 'AccountAdmin'
      @email_id = opts[:email_id] || "#{@email_prefix}#{SecureRandom.hex}@example.com"
    end

    def user_request_body
      {
        user: {
          name: @email_id,
          short_name: @short_name,
          terms_of_use: @terms_of_use,
          send_confirmation: @send_confirmation
        },
        pseudonym: {
          unique_id: @email_id,
          password: @password
        },
        force_validations: @force_validations
      }
    end

    def admin_request_body(id)
      {
        user_id: id,
        role_id: @role_id,
        send_confirmation: @send_confirmation
      }
    end
  end
end
