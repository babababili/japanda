# canvas user class
module CanvasFactory
  class User
    attr_reader :user_config, :user_response, :user_response_id,
                :user_response_email_id, :user_short_name, :user_password

    def initialize(user_config = CanvasFactory::UserConfig.new)
      @user_config = user_config
    end

    def create_learner_user
      user_end_point = "#{CANVAS_API_V1}/accounts/#{CANVAS_ACCOUNT_ID}/users"
      @user_response = CanvasFactory.perform_post(user_end_point, @user_config.user_request_body)
      @user_response_id = @user_response['id']
      @user_response_email_id = @user_response['login_id']
      @user_short_name = @user_config.short_name
      @user_password = @user_config.password
    end

    def create_admin_user
      create_learner_user
      body = @user_config.admin_request_body(@user_response['id'].to_i)
      admin_end_point = "#{CANVAS_API_V1}/accounts/#{CANVAS_ACCOUNT_ID}/admins"
      CanvasFactory.perform_post(admin_end_point, body)
    end
  end
end
