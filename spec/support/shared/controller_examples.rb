RSpec.shared_examples 'unauthorized action' do
  it 'returns unauthorized status' do
    action_call
    expect(response).to be_unauthorized
  end
end

RSpec.shared_examples 'requires authentication' do
  it 'redirects to login page' do
    action_call
    expect(response).to redirect_to new_user_session_path
  end
end
