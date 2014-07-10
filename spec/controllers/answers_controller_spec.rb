require 'rails_helper'
# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe AnswersController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Answer. As you add validations to Answer, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryGirl.build(:answer).attributes
  }

  let(:invalid_attributes) {
    FactoryGirl.build(:bad_answer).attributes
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AnswersController. Be sure to keep this updated too.
  let(:valid_session) { {} }
  
  # Create question for nested answer
  let!(:question) { FactoryGirl.create(:question) }
  let!(:answer) { FactoryGirl.create(:answer, question: question) }
  let!(:user) { User.last }
  before do
    # controller.stub(:authorize_resource).and_return(true)
    FactoryGirl.create(:user)
    sign_in User.last
  end
  describe "GET index" do
    it "assigns all answers as @answers" do
      get :index, {question_id: question.to_param}, valid_session
      expect(assigns(:answers)).to eq([answer])
    end
  end

  describe "GET show" do
    it "assigns the requested answer as @answer" do
      get :show, {id: answer.to_param, question_id: question.to_param}, valid_session
      expect(assigns(:answer)).to eq(answer)
    end
  end
  describe "GET new" do
    
    it "assigns a new answer as @answer" do
      get :new, {question_id: question.to_param}, valid_session
      expect(assigns(:answer)).to be_a_new(Answer)
    end
  end

  describe "GET edit" do
    it "assigns the requested answer as @answer" do
      get :edit, {id: answer.to_param, question_id: question.to_param}, valid_session
      expect(assigns(:answer)).to eq(answer)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Answer" do
        expect {
          post :create, { answer: valid_attributes,
                          question_id: question.to_param }, valid_session
        }.to change(Answer, :count).by(1)
      end

      it "assigns a newly created answer as @answer" do
        post :create, {
          answer: valid_attributes,
          question_id: question.to_param
          }, valid_session
        expect(assigns(:answer)).to be_a(Answer)
        expect(assigns(:answer)).to be_persisted
      end

      it "redirects to the created answer" do
        post :create, {
          answer: valid_attributes,
          question_id: question.to_param
          }, valid_session
        expect(response).to redirect_to(question_answers_path(question))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved answer as @answer" do
        post :create, {
          answer: invalid_attributes,
          question_id: question.to_param
          }, valid_session
        expect(assigns(:answer)).to be_a_new(Answer)
      end

      it "redirect_to answers index" do
        post :create, {
          answer: invalid_attributes,
          question_id: question.to_param
          }, valid_session
        expect(response).to redirect_to (question_answers_path(question))
      end
    end
  end

  describe "PUT update" do
    before do
      sign_in answer.user
    end
    describe "with valid params" do
      it "updates the requested answer" do
        put :update, {
          id: answer.to_param,
          answer: answer.attributes,
          question_id: question.to_param
          }, valid_session
        answer.reload
      end

      it "assigns the requested answer as @answer" do
        put :update, {
          id: answer.to_param,
          answer: answer.attributes,
          question_id: question.to_param
          }, valid_session
        expect(assigns(:answer)).to eq(answer)
      end

      it "redirects to the answer" do
        put :update, {
          id: answer.to_param,
          answer: answer.attributes,
          question_id: question.to_param
          }, valid_session
        expect(response).to redirect_to(question_answers_path(question))
      end
    end

    describe "with invalid params" do
      it "assigns the answer as @answer" do
        put :update, {
          id: answer.to_param,
          answer: invalid_attributes,
          question_id: question.to_param
          }, valid_session
        expect(assigns(:answer)).to eq(answer)
      end

      it "redirect_to answer index" do
        put :update, {
          id: answer.to_param,
          answer: invalid_attributes,
          question_id: question.to_param
          }, valid_session
        expect(response).to redirect_to(question_answers_path(question))
      end
    end
  end

  describe "DELETE destroy" do
    before do
      sign_in answer.user
    end
    it "destroys the requested answer" do
      expect {
        delete :destroy, {
          id: answer.to_param,
          question_id: question.to_param
          }, valid_session
      }.to change(Answer, :count).by(-1)
    end

    it "redirects to the answers list" do
      delete :destroy, {
        id: answer.to_param,
        question_id: question.to_param
        }, valid_session
      expect(response).to redirect_to(question_answers_path(question))
    end
  end

end
