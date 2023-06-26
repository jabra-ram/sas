class AgeCriteriaController < ApplicationController
    before_action :authorize
    def index 
        @age_criteria = AgeCriterium.all
    end
    def new
        @age_criteria = AgeCriterium.new
    end
    def create
        @age_criteria = AgeCriterium.new(age_criteria_params)
        if @age_criteria.save
            redirect_to age_criteria_path, notice:"Criteria added!"
        else 
            render "new", alert:"Something went wrong!!!"
        end
    end
    def destroy
        @age_criteria = AgeCriterium.find(params[:id])
        if @age_criteria.destroy
            redirect_to age_criteria_path, notice:"Data deleted successfully!"
        else 
            render "new", alert:"Something went wrong!"
        end
    end
    private
        def age_criteria_params
            params.require(:age_criterium).permit(:classname, :date_of_birth_after, :date_of_birth_before, :age, :date_as_on)
        end
end
