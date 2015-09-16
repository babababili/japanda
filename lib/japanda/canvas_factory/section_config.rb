module CanvasFactory
  class SectionConfig
    attr_accessor :name, :start_at, :end_at

    def initialize(opts = {})
      @name = opts[:name] || "section-#{Time.now.to_i}"
      @start_at = opts[:start_at] || Time.now
      @end_at = opts[:end_at] || Time.now + (30 * 24 * 60 * 60)
    end

    def request_body
      {
        course_section: {
          name: @name,
          start_at: @start_at,
          end_at: @end_at
        }
      }
    end
  end
end