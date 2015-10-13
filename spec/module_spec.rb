require 'spec_helper'

describe 'course module' do
  context 'with no hash' do
    let(:canvas_course) { CanvasFactory::Course.new }
    it 'should be created' do
      canvas_course.add_module
      expect(canvas_course.modules[0].course_id).to eql canvas_course.course_id
    end
  end

  context 'with hash merge' do
    let(:canvas_course) { CanvasFactory::Course.new }
    let(:module_name) { 'Calculus' }
    let(:opts) { { module: { name:module_name,require_sequential_progress: false } } }
    it 'should be created' do
      canvas_course.add_module opts
      expect(canvas_course.modules.size).to eq 1
      expect(canvas_course.modules[0].course_id).to eql canvas_course.course_id
      expect(canvas_course.modules[0].name).to eql module_name
    end
  end

  context 'with hash' do
    let(:canvas_course) { CanvasFactory::Course.new }
    let(:module_name) { 'Calculus' }
    let(:opts) { {
      module: {
        name: module_name,
        unlock_at: DateTime.now.iso8601,
        require_sequential_progress: false
      }
    } }
    it 'should be created' do
      canvas_course.add_module opts, false
      expect(canvas_course.modules.size).to eq 1
      expect(canvas_course.modules[0].course_id).to eql canvas_course.course_id
      expect(canvas_course.modules[0].name).to eql module_name
    end
  end
end
