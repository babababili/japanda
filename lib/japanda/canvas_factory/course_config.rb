module CanvasFactory
  class CourseConfig
    attr_accessor :account_id, :name, :course_code, :start_at, :end_at, :offer

    def initialize(opts = {})
      course_name_code = "auto#{SecureRandom.hex}"
      @account_id = opts[:account_id] || CANVAS_ACCOUNT_ID
      @name = opts[:name] || course_name_code
      @course_code = opts[:course_code] || course_name_code
      @start_at = opts[:start_at] || Time.now
      @end_at = opts[:end_at] || Time.now + (30 * 24 * 60 * 60)
      @offer = opts[:offer] || true
    end

    def request_body
      {
        account_id: @account_id,
        course: {
          name: @name,
          course_code: @course_code,
          start_at: @start_at,
          end_at: @end_at
        },
        offer: @offer
      }
    end
  end
end