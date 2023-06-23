class SessionsController < ApplicationController
    def new 
        if current_admin
            flash[:notice] = "You are already logged in!"
            redirect_to admins_path
        end
        @admin = Admin.new
    end

    def create
        @admin = Admin.find_by(email: params[:email])
        
        if @admin && @admin.authenticate(params[:password])
            session[:admin_id] = @admin.id 
            flash[:notice] = "Logged In"
            redirect_to admins_path
        else 
            flash.now[:alert] = "Incorrect email or password!"
            render "new"
        end
    end

    def destroy 
        session[:admin_id]=nil
        flash[:notice] = "Logged Out!"
        redirect_to login_path
    end
end
