class SessionsController < ApplicationController
    def new 
        if current_admin
            redirect_to admins_path, notice:"You are already logged in!"
        end
        @admin = Admin.new
    end

    def create
        @admin = Admin.find_by(email: params[:email])
        
        if @admin && @admin.authenticate(params[:password])
            session[:admin_id] = @admin.id 
            redirect_to admins_path, notice:"Logged In"
        else 
            render :new, alert:"Incorrect email or password!"
        end
    end

    def destroy 
        session[:admin_id]=nil
        flash[:notice] = "Logged Out!"
        redirect_to login_path
    end
end
