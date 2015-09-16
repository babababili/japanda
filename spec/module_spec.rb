require 'spec_helper'

describe 'course module' do
  context 'with no config' do
    let(:canvas_course) { CanvasFactory::Course.new }
    let(:course_module) { CanvasFactory::Module.new(canvas_course.course_id) }
    it 'should be created' do
      expect(course_module.course_id).to eql canvas_course.course_id
      expect(course_module.published).to be true
    end
  end

  context 'with config' do
    let(:canvas_course) { CanvasFactory::Course.new }
    let(:module_name) { 'Calculus' }
    it 'should be created' do
      module_config = CanvasFactory::ModuleConfig.new(end_at: Time.now)
      module_config.name = module_name
      module_config.require_sequential_progress = true
      course_modules = []
      course_modules << CanvasFactory::Module.new(canvas_course.course_id, module_config)
      expect(course_modules.size).to eq 1
      course_modules.each do |m|
        expect(m.require_sequential_progress).to be module_config.require_sequential_progress
        expect(m.name).to eql module_name
      end
    end
  end
end
