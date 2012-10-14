class ApplicationController < ActionController::Base
  protect_from_forgery

  def email_me
    File.open(File.expand_path('../../../lib/emails.txt', __FILE__), "w") do |f|
      f.write(params[:email] + "\n")
    end

    redirect_to root_path, notice: "Thanks for signing up!"
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      if resource.is_a?(User)
        medications_path
      else
        super
      end
  end
end
