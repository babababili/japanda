require 'spec_helper'

describe 'course' do
  context 'with no config' do
    let(:canvas_course) { CanvasFactory::Course.new }
    it 'should be created' do
      expect(canvas_course.course_code).to include 'auto'
      expect(canvas_course.course_name).to include 'auto'
      expect(canvas_course.course_id).to be
    end
  end

  context 'with config' do
    let(:course_name) { 'coursename' }
    let(:course_code) { "code-change#{SecureRandom.hex}" }
    let(:course_config) { CanvasFactory::CourseConfig.new(name: course_name) }
    let(:canvas_course) do
      course_config.course_code = course_code
      CanvasFactory::Course.new(course_config)
    end
    it 'should be created' do
      expect(canvas_course.course_code).to include course_code
      expect(canvas_course.course_name).to include course_name
      expect(canvas_course.course_id).to be_truthy
    end
  end
end
