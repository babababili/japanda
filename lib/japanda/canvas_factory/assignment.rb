# assignment class
module CanvasFactory
  class Assignment
    attr_reader :id, :name, :course_id, :html_url, :grading_type, :published, :due_at, :created_at

    def initialize(course_id, assignment_config = CanvasFactory::AssignmentConfig.new)
      fail 'invalid course_id' if course_id.nil?
      @course_id = course_id
      create_assignment course_id, assignment_config
    end

    def create_assignment(course_id, assignment_config)
      assign_end_point = "#{CANVAS_API_V1}/courses/#{course_id}/assignments"
      response = CanvasFactory.perform_post(assign_end_point, assignment_config.request_body)
      @id = response['id']
      @name = response['name']
      @html_url = response['html_url']
      @grading_type = response['grading_type']
      @published = response['published']
      @created_at = response['created_at']
      @due_at = response['due_at']
      self
    end
  end
end
