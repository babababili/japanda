# canvas module class
module CanvasFactory
  class Module
    attr_reader :module, :course_id, :name, :id, :position, :unlock_at, :require_sequential_progress,
                :publish_final_grade, :prerequisite_module_ids, :published, :items_count, :items_url,
                :assignments

    def initialize(course_id, module_config = CanvasFactory::ModuleConfig.new)
      @assignments = []
      create_module course_id, module_config
      publish_module
    end

    def create_module(course_id, module_config)
      m_item_end_point = "#{CANVAS_API_V1}/courses/#{course_id}/modules"
      response = CanvasFactory.perform_post(m_item_end_point, module_config.request_body)
      @course_id = course_id
      @id = response['id']
      @name = response['name']
      @position = response['position']
      @unlock_at = response['unlock_at']
      @require_sequential_progress = response['require_sequential_progress']
      @publish_final_grade = response['publish_final_grade']
      @prerequisite_module_ids = response['prerequisite_module_ids']
      @published = response['published']
      @items_count = response['items_count']
      @items_url = response['items_url']
    end

    def publish_module
      body = {
        module: {
          published: true
        }
      }
      m_p_end_point = "#{CANVAS_API_V1}/courses/#{@course_id}/modules/#{@id}"
      response = CanvasFactory.perform_put(m_p_end_point, body)
      @published = response['published']
    end

    def add_module_item(module_item_request)
      item_end_point = "#{CANVAS_API_V1}/courses/#{@course_id}/modules/#{@id}/items"
      CanvasFactory.perform_post(item_end_point, module_item_request)
      publish_module
    end

    def add_assignment(title = 'module_assignment', assignment_config = CanvasFactory::AssignmentConfig.new)
      assignment = CanvasFactory::Assignment.new(@course_id, assignment_config)
      module_item_config = CanvasFactory::ModuleItemConfig.new(module_item_type: 'Assignment',
                                                               completion_type: 'must_view')
      module_item_config.content_id = assignment.id
      module_item_config.title = title
      add_module_item(module_item_config.request_body)
      @assignments << assignment
      assignment
    end
  end
end
