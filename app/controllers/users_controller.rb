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
    puts "PIN - #{pin}, ASECRET - #{asecret}, ATOKEN - #{atoken}"
    puts client.inspect
    puts client.profile
    clientData = client.profile

    #Find or create user based on linkedin id
    @user = User.find_for_linkedin_oauth(clientData, current_user)
    puts "INSPECTING USER \n ==================="
    puts @user.inspect
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
      redirect_to '/404'
    end
  end

  def createlinkedin
    @user = User.find_by_linkedin_id(params[:linkedin_id])
    if @user.security_string == params[:security_string]
      @user.email = params[:user][:email]
      if @user.save
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
