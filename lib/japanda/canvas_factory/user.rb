module CanvasFactory
  # canvas user class
  class User
    attr_reader :learner_request, :user_response, :id, :admin_request,
                :email_id, :short_name, :password

    def initialize(opts = {}, merge = true)
      unique_email = "#{@email_prefix}#{SecureRandom.hex}@example.com"
      @learner_request = {
        user: {
          name: unique_email,
          short_name: 'auto user',
          terms_of_use: '1',
          send_confirmation: true
        },
        pseudonym: {
          unique_id: unique_email,
          password: 'Testing01'
        },
        force_validations: true
      }
      @learner_request = Mergie.deep_merge(@learner_request, opts, merge)
      create_learner_user
    end

    private

    def create_learner_user
      user_end_point = "#{CANVAS_API_V1}/accounts/#{CANVAS_ACCOUNT_ID}/users"
      @user_response = CanvasFactory.perform_post(user_end_point, @learner_request)
      @id = @user_response['id']
      @email_id = @user_response['login_id']
      @short_name = @user_response['short_name']
      @password = @learner_request[:pseudonym][:password]
      @user_response
    end
  end

  # canvas admin user class
  class AdminUser < User
    def initialize(opts = {}, merge = true)
      super(opts, merge)
      make_admin_user
    end

    private

    def make_admin_user
      @admin_request = {
        user_id: @id,
        role_id: 'AccountAdmin',
        send_confirmation: true
      }
      admin_end_point = "#{CANVAS_API_V1}/accounts/#{CANVAS_ACCOUNT_ID}/admins"
      CanvasFactory.perform_post(admin_end_point, @admin_request)
    end
  end
end
