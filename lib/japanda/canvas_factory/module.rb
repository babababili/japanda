module CanvasFactory
  # canvas module class
  class Module
    attr_reader :course_id, :name, :module_id, :published, :request, :response,
                :module_items, :publish_response, :publish_request

    def initialize(course_id, opts = {}, merge = true)
      @module_items = []
      @course_id = course_id
      @request = {
        module: {
          name: "module-#{Time.now.to_i}",
          unlock_at: DateTime.now.iso8601,
          require_sequential_progress: true
        }
      }
      @request = Mergie.deep_merge(@request, opts, merge)
      create_module
      self
    end

    def add_module_item(content, opts = {}, merge = true) # content can be assignment or quiz ...
      module_item = CanvasFactory::ModuleItem.new(@course_id, @module_id, content, opts, merge)
      @module_items << module_item
      module_item
    end

    def publish(opts = {}, merge = true)
      @publish_request = {
        module: {
          published: true
        }
      }
      @publish_request = Mergie.deep_merge(@publish_request, opts, merge)
      publish_ep = "#{CANVAS_API_V1}/courses/#{@course_id}/modules/#{@module_id}"
      @publish_response = CanvasFactory.perform_put(publish_ep, @publish_request)
      @published = @publish_response['published']
    end

    private

    def create_module
      m_item_end_point = "#{CANVAS_API_V1}/courses/#{@course_id}/modules"
      @response = CanvasFactory.perform_post(m_item_end_point, @request)
      @course_id = course_id
      @module_id = response['id']
      @name = response['name']
      @published = response['published']
    end
  end
end
