module CanvasFactory
  # module item class
  class ModuleItem
    attr_reader :item_id, :name, :course_id, :html_url, :title, :published, :type,
                :created_at, :request, :response, :module_id

    def initialize(course_id, module_id, content, opts = {}, merge = true)
      @course_id = course_id
      @module_id = module_id
      @request = {
        module_item: {
          title: "module-item#{SecureRandom.hex}",
          type: content.class.name.split('::').last || '',
          content_id: content.id,
          completion_requirement: {
            type: 'must_view'
          }
        }
      }
      @request = Mergie.deep_merge(@request, opts, merge)
      create_item
      self
    end

    private

    def create_item
      item_end_point = "#{CANVAS_API_V1}/courses/#{@course_id}/modules/#{@module_id}/items"
      @response = CanvasFactory.perform_post(item_end_point, @request)
      @published = response['published']
      @item_id = response['id']
      @type = response['type']
      @title = response['title']
      @html_url = response['html_url']
    end
  end
end
