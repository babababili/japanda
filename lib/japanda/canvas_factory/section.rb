# canvas section class
module CanvasFactory
  class Section
    attr_reader :course_id, :id, :end_at, :start_at, :name, :sis_section_id, :sis_course_id,
                :integration_id, :sis_import_id, :nonxlist_course_id

    def initialize(course_id, section_config = CanvasFactory::SectionConfig.new)
      create_section course_id, section_config
    end

    def create_section(course_id, section_config)
      section_end_point = "#{CANVAS_API_V1}/courses/#{course_id}/sections"
      response = CanvasFactory.perform_post(section_end_point, section_config.request_body)
      @course_id = response['course_id']
      @id = response['id']
      @name = response['name']
      @end_at = response['end_at']
      @start_at = response['start_at']
      @sis_section_id = response['sis_section_id']
      @sis_course_id = response['sis_course_id']
      @integration_id = response['integration_id']
      @sis_import_id = response['sis_import_id']
      @nonxlist_course_id = response['nonxlist_course_id']
    end
  end
end
