require 'spec_helper'

describe 'course section' do
  context 'with no config' do
    let(:canvas_course) { CanvasFactory::Course.new }
    let(:course_section) { CanvasFactory::Section.new(canvas_course.course_id) }
    it 'should be created' do
      expect(canvas_course.course_id).to be_truthy
    end
  end

  context 'with config' do
    let(:canvas_course) { CanvasFactory::Course.new }
    it 'should be created' do
      section_config = CanvasFactory::SectionConfig.new(end_at: Time.now)
      section_config.name = 'first section'
      section_config.start_at = Time.now
      section_config.end_at = Time.now + (7 * 24 * 60 * 60)
      course_sections = []
      course_sections << CanvasFactory::Section.new(canvas_course.course_id, section_config)
      expect(course_sections.first.course_id).to eql canvas_course.course_id
      expect(course_sections.first.start_at).to be_truthy
      expect(course_sections.first.start_at).to include section_config.start_at.to_date.to_s
      expect(course_sections.first.end_at).to be_truthy
      expect(course_sections.first.end_at).to include section_config.end_at.to_date.to_s
      expect(course_sections.size).to eq 1
    end
  end
end
