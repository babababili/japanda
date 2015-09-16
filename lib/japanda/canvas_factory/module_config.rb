module CanvasFactory
  class ModuleConfig
    attr_accessor :name, :unlock_at, :require_sequential_progress

    def initialize(opts = {})
      @name = opts[:name] || "module-#{Time.now.to_i}"
      @unlock_at = opts[:unlock_at] || DateTime.now.iso8601
      @require_sequential_progress = opts[:require_sequential_progress] || true
      @published = opts[:published] || true
    end

    def request_body
      {
        module: {
          name: @name,
          unlock_at: @unlock_at,
          require_sequential_progress: @require_sequential_progress
        }
      }
    end
  end
end
