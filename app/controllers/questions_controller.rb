class QuestionsController < ApplicationController
  respond_to :json
  # GET /quizzes/:quiz_id/questions/next.json
  def next
    quiz = Quiz.find(params[:quiz_id])
    if quiz
      question = quiz.questions.first
      render json: question.to_json
    else
      render status: :unprocessable_entity, json: { message: "#{quiz.id} is not a valid quiz id!" }.to_json
    end
  end

  # POST /questions/:question_id/answers.json
  def answer
    question = Question.find(params[:question_id])
    submitted_choice = Choice.find(params[:choice_id])
    correct_choice = question.choices.where(is_correct: true).first
    if question
      render json: {
        id: question.id,
        more_questions: false,
        correct: submitted_choice.id == correct_choice.id,
        submitted_choice: submitted_choice.id,
        correct_choice: correct_choice.id,
        num_correct: (submitted_choice.id == correct_choice.id) ? 1 : 0,
        num_incorrect: (submitted_choice.id == correct_choice.id) ? 0 : 1
      }.to_json
    else
      render status: :unprocessable_entity, json: { message: "#{question.id} is not a valid question id!" }.to_json
    end
  end
end
