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
        if AgeCriterium.where(class_category_id: params[:age_criterium][:class_category_id]).empty? == false
            redirect_to age_criteria_path, notice:'Age criteria already exist for this class!'
        elsif @age_criteria.save
            redirect_to age_criteria_path, notice:'Criteria added!'
        else 
            render :new
        end
    end
    def edit
        @age_criteria = AgeCriterium.find(params[:id])
    end
    def update
        @age_criteria = AgeCriterium.find(params[:id])
        if @age_criteria.update(age_criteria_params)
            redirect_to age_criteria_path, notice:'Criteria updated!'
        else 
            redirect_to edit_age_creteria_path, alert:'Something went wrong!!!'
        end
    end
    def destroy
        @age_criteria = AgeCriterium.find(params[:id])
        if @age_criteria.destroy
            redirect_to age_criteria_path, notice:'Data deleted successfully!'
        else 
          render :new
        end
    end
    private
        def age_criteria_params
            params.require(:age_criterium).permit(:class_category_id, :date_of_birth_after, :date_of_birth_before, :age, :date_as_on)
        end
end
