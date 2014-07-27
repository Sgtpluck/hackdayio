require_relative '../spec_helper'

describe HackdaysController do
  before do
    @user = Fabricate(:user)
    session[:user_id] = @user.id
    @hackday = Fabricate(:hackday)
  end

  describe '#update' do
    context 'with valid attributes' do
      it 'should update the hackday and give you a flash telling you so' do
        put :update, id: @hackday.id, hackday: { presentation_in_progress: true}
        @hackday.reload
        expect(flash[:message]).to eq "Updated your Hack Day"
        expect(response).to be_redirect
        expect(@hackday.presentation_in_progress).to eq true
      end
    end

    context 'with invalid attributes' do
      it 'should not update the hackday and let the user know why' do
        put :update, id: @hackday.id, hackday: {title: nil}
        @hackday.reload
        expect(flash[:error]).to eq "Title can't be blank"
        expect(response).to be_redirect
        expect(@hackday.title).to eq "Hackapalooza"
      end
    end
  end

end