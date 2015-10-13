require 'spec_helper'

describe 'course' do
  context 'with no hash' do
    let(:canvas_course) { CanvasFactory::Course.new }
    it 'should be created' do
      expect(canvas_course.course_code).to include 'auto'
      expect(canvas_course.course_name).to include 'auto'
      expect(canvas_course.course_id).to be
    end
  end

  context 'with hash merge' do
    let(:opts) { { course:{ name: 'coursename1', course_code: "code-change#{SecureRandom.hex}" } } }
    let(:canvas_course) do
      CanvasFactory::Course.new(opts)
    end
    it 'should be created' do
      expect(canvas_course.course_code).to include opts[:course][:course_code]
      expect(canvas_course.course_name).to include opts[:course][:name]
      expect(canvas_course.course_id).to be_truthy
    end
  end

  context 'with hash' do
    let(:opts) { {
      account_id: '1',
      course: {
        name: "code-name#{SecureRandom.hex}",
        course_code: "course_code#{SecureRandom.hex}"
      },
      offer: true
    } }
    let(:canvas_course) do
      CanvasFactory::Course.new(opts, false)
    end
    it 'should be created' do
      expect(canvas_course.course_code).to include opts[:course][:course_code]
      expect(canvas_course.course_name).to include opts[:course][:name]
      expect(canvas_course.course_response[:end_at]).not_to be
      expect(canvas_course.course_id).to be_truthy
    end
  end
end
