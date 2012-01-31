module SessionsHelper

  private

    def authenticate
    	deny_access unless signed_in?
    end
    
    def signed_in?
    	session[:user_id] != nil
    end
    
    def deny_access
    	redirect_to root_path, :notice => "Please sign in to access this page."
  	end
end
