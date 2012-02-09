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
  	
  	def current_user=(user)
    	@current_user = user
  	end
  
  	def current_user
  		@current_user ||= User.find(session[:user_id]) if session[:user_id]
  	end

    def admin_user
     	redirect_to(root_path) unless current_user.admin?
    end
    
    def no_banned_users
     	redirect_to(root_path) if current_user.banned?
    end
end
