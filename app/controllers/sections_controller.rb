class SectionsController < ApplicationController
    before_action :authorize
    
    def index
        @sections = Section.all
    end
    def new
        @section = Section.new
    end
    def create 
        @section = Section.new(section_params)
        if @section.save
            redirect_to sections_path, notice:"Section created successfully!"
        else
            render "new", alert:"Enter correct details please!"
        end
    end
    def destroy 
        @section = Section.find(params[:id])
        if @section.destroy
            redirect_to sections_path, notice:"Section deleted successfully!"
        else 
            render "new", alert:"Something went wrong!!!"
        end
    end
    private
        def section_params
            params.require(:section).permit(:section)
        end
end
 