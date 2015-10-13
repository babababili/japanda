require 'spec_helper'

describe 'course section' do
  context 'with no hash' do
    let(:canvas_course) { CanvasFactory::Course.new }
    it 'should be created' do
      canvas_course.add_section
      expect(canvas_course.sections.size).to eq(1)
      expect(canvas_course.sections[0].course_id).to eql canvas_course.course_id
    end
    it 'multiple sections should be created' do
      random_number = rand(2..5)
      random_number.times { canvas_course.add_section }
      expect(canvas_course.sections.size).to eq(random_number)
      expect(canvas_course.sections[0].course_id).to eql canvas_course.course_id
    end
  end

  context 'with hash merge' do
    let(:sec_name) { "hashie-section-name#{Time.now.to_i}" }
    let(:st_at) { Time.now }
    let(:ed_at) { Time.now + (7 * 24 * 60 * 60) }
    let(:opts) { { course_section:{ name: sec_name, start_at: st_at, end_at: ed_at } }}
    let(:canvas_course) { CanvasFactory::Course.new }
    it 'should be created' do
      canvas_course.add_section(opts)
      expect(canvas_course.sections.size).to eq 1
      expect(canvas_course.sections[0].course_id).to eql canvas_course.course_id
      expect(canvas_course.sections[0].start_at).to be_truthy
      expect(canvas_course.sections[0].start_at).to include st_at.to_date.to_s
      expect(canvas_course.sections[0].end_at).to be_truthy
      expect(canvas_course.sections[0].end_at).to include ed_at.to_date.to_s
    end
  end

  context 'with hash' do
    let(:sec_name) { "sec-names#{Time.now.to_i}" }
    let(:st_at) { Time.now }
    let(:ed_at) { Time.now + (7 * 24 * 60 * 60) }
    let(:opts) { {
      course_section: {
        name: sec_name,
        start_at: st_at,
        end_at: ed_at,
        restrict_enrollments_to_section_dates: false
      } } }
    let(:canvas_course) { CanvasFactory::Course.new }
    it 'should be created' do
      canvas_course.add_section(opts, false)
      expect(canvas_course.sections.size).to eq 1
      expect(canvas_course.sections[0].course_id).to eql canvas_course.course_id
      expect(canvas_course.sections[0].start_at).to be_truthy
      expect(canvas_course.sections[0].start_at).to include st_at.to_date.to_s
      expect(canvas_course.sections[0].end_at).to be_truthy
      expect(canvas_course.sections[0].end_at).to include ed_at.to_date.to_s
    end
  end
end
