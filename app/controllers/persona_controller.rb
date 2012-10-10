class PersonaController < ApplicationController

  # verifies the load and logs the user in
  def login
    data = validate_assertion(params[:assertion])

    if data['status'] == 'okay'
      self.current_user = User.find_or_create_by(email: data['email'])
    end

    render json: data
  end

  # flushes the session
  def logout
    self.current_user = nil
    render text: ''
  end

  private

  # validates that the assertion is really issued by the provider
  def validate_assertion(assertion)
    Nestful.post 'https://verifier.login.persona.org/verify',
      format: :json,
      params: { assertion: assertion, audience: url_for(:root) }
  end

end
