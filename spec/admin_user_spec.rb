require 'spec_helper'

describe 'admin user' do
  context 'with no hash' do
    let(:canvas_user) { CanvasFactory::AdminUser.new }
    it 'should be created as an admin' do
      expect(canvas_user.id).to be
      expect(canvas_user.email_id).to match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
    end
  end

  context 'with hash merge' do
    let(:name) { 'New Admin' }
    let(:opts) { { user:{ short_name:name }} }
    let(:canvas_user) { CanvasFactory::AdminUser.new(opts) }
    it 'should be created as an admin' do
      expect(canvas_user.short_name).to eql name
      expect(canvas_user.id).to be
      expect(canvas_user.email_id).to match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
    end
  end

  context 'with hash' do
    let(:unique_email) { "#{@email_prefix}#{SecureRandom.hex}@example.com" }
    let(:pwd) { 'SaltLakeCity84121' }
    let(:opts) { {
      user: {
        name: unique_email,
        short_name: 'auto user',
        terms_of_use: '1',
        send_confirmation: true
      },
      pseudonym: {
        unique_id: unique_email,
        password: pwd
      },
      force_validations: true
    } }
    let(:canvas_user) { CanvasFactory::AdminUser.new(opts, false) }
    it 'should be created as an admin' do
      expect(canvas_user.id).to be
      expect(canvas_user.password).to eql pwd
      expect(canvas_user.email_id).to match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
    end
  end

end
