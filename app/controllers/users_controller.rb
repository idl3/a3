class UsersController < Devise::OmniauthCallbacksController
  def omniauth
    if params[:provider] == "linkedin"
      client = LinkedIn::Client.new("3iw78vkjq6tj","qcCzncUqibKDpTdJ")
      request_token = client.request_token(:oauth_callback =>
                                           "http://#{request.host_with_port}/linkedin-callback")
      session[:rtoken] = request_token.token
      session[:rsecret] = request_token.secret
      redirect_to client.request_token.authorize_url

    else
      redirect_to '404'
    end
  end

  def linkedin
    pin = params[:oauth_verifier]
    client = LinkedIn::Client.new("3iw78vkjq6tj","qcCzncUqibKDpTdJ")
    atoken,asecret = client.authorize_from_request(session[:rtoken],session[:rsecret],pin)
    client.authorize_from_access(atoken,asecret)
    session[:client] = client
    clientData = client.profile(id: nil, fields: ['first-name','last-name','site-standard-profile-request','public-profile-url','picture-url'])

    @user = User.find_for_linkedin_oauth(clientData, current_user)
    @user.update_attribute(:meta, {picture_url: clientData.picture_url})
    unless @user.email.blank?
      flash[:success] = "Signed in successfully with Linkedin"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.linkedin_data"] = request.env["omniauth.auth"]
      redirect_to linkedin_registration_path(@user.linkedin_id, @user.security_string)
    end
  end

  def newlinkedin
    @user = User.find_by_linkedin_id(params[:linkedin_id])
    unless @user and @user.security_string == params[:security_string]
      flash[:alert] = "Page does not exist"
      redirect_to root_path
    end
  end

  def createlinkedin
    @user = User.find_by_linkedin_id(params[:linkedin_id])
    if @user.security_string == params[:security_string]
      @user.email = params[:user][:email]
      if @user.save
        require 'securerandom'
        @user.update_attribute(:security_string, SecureRandom.hex(16))
        flash[:success] = "Successfully completed linkedin signup!"
        sign_in_and_redirect @user, :event => :authentication
      else
        flash[:alert] = "Email already exists, use a new email or sign in using that account"
        redirect_to linkedin_registration_path(@user.linkedin_id)
      end
    else
      redirect_to root_path
    end
  end
end
