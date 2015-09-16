module CanvasFactory
  class ModuleItemConfig
    attr_accessor :module_item_type, :content_id, :completion_type, :title

    def initialize(opts = {})
      @module_item_type = opts[:module_item_type] || 'Assignment'
      @content_id = opts[:content_id]
      @completion_type = opts[:completion_type] || 'must_view'
      @title = opts[:title] || 'module_assignment'
    end

    def request_body
      {
        module_item: {
          title: @title,
          type: @module_item_type,
          content_id: @content_id,
          completion_requirement: {
            type: @completion_type
          }
        }
      }
    end
  end
end