# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  describe '#DELETE destroy' do
    before { login(user) }

    let(:attachment) { question.files.first }

    subject { delete :destroy, params: { id: attachment, format: :js } }

    context 'user is question owner' do
      let!(:question) { create(:question, :with_file, user: user) }

      it { expect { subject }.to change(ActiveStorage::Attachment, :count).by(-1) }
      it do
        subject
        expect(response).to render_template(:destroy)
      end
    end

    context 'user is not question owner' do
      let!(:question) { create(:question, :with_file, user: another_user) }

      it { expect { subject }.to_not change(ActiveStorage::Attachment, :count) }
      it do
        subject
        expect(response).to render_template('questions/show')
      end
    end
  end
end
