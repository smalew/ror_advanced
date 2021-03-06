# frozen_string_literal: true

require 'rails_helper'

feature 'User can destroy answer', "
  In order to remove answer from community
  As a authenticated user
  I'd like to ba able to destroy answer
" do
  describe 'Authenticated user', js: true do
    given(:user) { create(:user) }
    given(:another_user) { create(:user) }

    background { sign_in(user) }

    context 'own answer' do
      context 'in own question' do
        given!(:question) { create(:question, user: user) }
        given!(:answer) { create(:answer, user: user, question: question) }

        scenario 'successful destroy' do
          visit question_path(question)

          within '.answers' do
            click_on I18n.t('answer.destroy_button')

            expect(page).to_not have_content(answer.body)
          end
        end
      end

      context "in someone else's question" do
        given!(:question) { create(:question, user: another_user) }
        given!(:answer) { create(:answer, user: user, question: question) }

        scenario 'successful destroy' do
          visit question_path(question)

          within '.answers' do
            click_on I18n.t('answer.destroy_button')

            expect(page).to_not have_content(answer.body)
          end
        end
      end
    end

    context "someone else's answer" do
      context 'in own question' do
        given!(:question) { create(:question, user: user) }
        given!(:answer) { create(:answer, user: another_user, question: question) }

        scenario 'failure destroy' do
          visit question_path(question)

          within '.answers' do
            expect(page).to_not have_link(I18n.t('answer.destroy_button'))
          end
        end
      end

      context "in someone else's question" do
        given!(:question) { create(:question, user: another_user) }
        given!(:answer) { create(:answer, user: another_user, question: question) }

        scenario 'failure destroy' do
          visit question_path(question)

          within '.answers' do
            expect(page).to_not have_link(I18n.t('answer.destroy_button'))
          end
        end
      end
    end
  end
end
