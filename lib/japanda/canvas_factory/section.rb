module CanvasFactory
  # canvas section class
  class Section
    attr_reader :course_id, :id, :end_at, :start_at, :name, :sis_section_id, :sis_course_id,
                :integration_id, :sis_import_id, :nonxlist_course_id, :request, :response

    def initialize(course_id, opts = {}, merge = true)
      @course_id = course_id
      @request = {
        course_section: {
          name: "section-#{Time.now.to_i}",
          start_at: Time.now,
          end_at: Time.now + (30 * 24 * 60 * 60),
          restrict_enrollments_to_section_dates: false,
          # enable_sis_reactivation: false,
          # sis_section_id: nil
        }
      }
      @request = Mergie.deep_merge(@request, opts, merge)
      create_section
      self
    end

    private

    def create_section
      section_end_point = "#{CANVAS_API_V1}/courses/#{@course_id}/sections"
      @response = CanvasFactory.perform_post(section_end_point, @request)
      @course_id = response['course_id']
      @id = response['id']
      @name = response['name']
      @end_at = response['end_at']
      @start_at = response['start_at']
    end
  end
end
