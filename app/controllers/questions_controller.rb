class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
  end

  def show
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    if question.save
      redirect_to question, notice: I18n.t('question.successful_create')
    else
      render :new
    end
  end

  def update
    if question.update(question_params)
      redirect_to question
    else
      render :edit
    end
  end

  def destroy
    question.destroy

    redirect_to questions_path
  end

  private

  def questions
    @questions ||= Question.all
  end
  helper_method :questions

  def question
    @question ||= params[:id].present? ? Question.find(params[:id]) : Question.new(question_params)
  end
  helper_method :question

  def answers
    @answers ||= question.answers
  end
  helper_method :answers

  def answer
    @answer ||= question.answers.build
  end
  helper_method :answer

  def question_params
    params.require(:question).permit(:title, :body)
  end
end