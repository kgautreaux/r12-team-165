class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_twitter(request.env["omniauth.auth"], current_user)
    Rails.logger.info(request.env["omniauth.auth"].to_yaml)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"].except("extra")
      flash[:alert] = "Could not link account to twitter.  Perhaps your Twitter nickname is not public?"
      redirect_to new_user_registration_url
    end
  end

  
  def github
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.find_for_github(request.env["omniauth.auth"], current_user)

      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Github"
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.github_data"] = request.env["omniauth.auth"]
        flash[:alert] = "Could not link account to github.  Perhaps your email address is not public?"
        redirect_to new_user_registration_url
      end
  end
end
