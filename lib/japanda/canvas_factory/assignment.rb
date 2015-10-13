module CanvasFactory
  # assignment class
  class Assignment
    attr_reader :id, :name, :course_id, :html_url, :grading_type, :published, :due_at,
                :created_at, :request, :response

    def initialize(course_id, opts = {}, merge = true)
      @course_id = course_id
      @request = {
        assignment: {
          name: "Assignment-#{Time.now.to_i}",
          grading_type: %w(pass_fail percent letter_grade gpa_scale points).sample,
          submission_types: ['online_text_entry'],
          points_possible: 10,
          due_at: (DateTime.now + 1).iso8601,
          published: true
        }
      }
      @request = Mergie.deep_merge(@request, opts, merge)
      create_assignment
      self
    end

    private

    def create_assignment
      assign_end_point = "#{CANVAS_API_V1}/courses/#{@course_id}/assignments"
      @response = CanvasFactory.perform_post(assign_end_point, @request)
      @id = response['id']
      @name = response['name']
      @html_url = response['html_url']
      @grading_type = response['grading_type']
      @published = response['published']
      @created_at = response['created_at']
      @due_at = response['due_at']
    end
  end
end
