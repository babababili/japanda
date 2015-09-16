# canvas course class
module CanvasFactory
  class Course
    attr_reader :course_response, :course_id, :course_code, :course_name, :offer

    def initialize(course_config = CanvasFactory::CourseConfig.new)
      @offer = course_config.offer
      create_course course_config
    end

    def create_course(course_config)
      course_end_point = "#{CANVAS_API_V1}/accounts/#{course_config.account_id}/courses"
      @course_response = CanvasFactory.perform_post(course_end_point, course_config.request_body)
      @course_id = @course_response['id']
      @course_name = @course_response['name']
      @course_code = @course_response['course_code']
      self
    end
  end
end
