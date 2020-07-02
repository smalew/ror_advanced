require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  before { sign_in(user) }

  describe '#GET edit' do
    before { get :edit, params: { question_id: question, id: answer } }

    it { expect(response).to render_template(:edit) }
  end

  describe '#POST create' do
    subject { post :create, params: { question_id: question, answer: answer_params } }

    context 'with valid attributes' do
      let(:answer_params) { attributes_for(:answer) }

      it { expect { subject }.to change(Answer, :count).by(1) }
      it { expect { subject }.to change(question.answers, :count).by(1) }
      it do
        subject
        expect(response).to redirect_to(question_path(question))
      end
    end

    context 'with invalid attributes' do
      context 'when body empty' do
        let(:answer_params) { attributes_for(:answer, :empty_body) }

        it { expect { subject }.to_not change(Answer, :count) }
        it do
          subject
          expect(response).to render_template('questions/show')
        end
      end
    end
  end

  describe '#PATCH update' do
    before { patch :update, params: { question_id: question, id: answer, answer: answer_params } }

    context 'with valid attributes' do
      let(:answer_params) { { body: 'new_body' } }

      it { expect(response).to redirect_to(question_path(question)) }
      it { expect(assigns(:answer)).to eq(answer) }
      it { expect(answer.reload.body).to eq('new_body') }
    end

    context 'with invalid attributes' do
      context 'when body empty' do
        let(:answer_params) { attributes_for(:answer, :empty_body) }

        it { expect(response).to render_template(:edit) }
        it { expect(assigns(:answer)).to eq(answer) }
        it { expect(answer.reload.body).to eq(answer.body) }
      end
    end
  end

  describe '#DELETE destroy' do
    let!(:question) { create(:question) }
    let!(:answer) { create(:answer, question: question) }

    subject { delete :destroy, params: { question_id: question, id: answer } }

    it { expect { subject }.to change(Answer, :count).by(-1) }
    it do
      subject
      expect(response).to redirect_to(question_answers_path(question))
    end
  end
end