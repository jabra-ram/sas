class FeeStructuresController < ApplicationController
    before_action :authorize
    def index
        @fee_structures = FeeStructure.all
    end
    def new
        @fee_structure = FeeStructure.new
    end
    def create 
        @fee_structure = FeeStructure.new(fee_structure_params)
        if @fee_structure.save
            redirect_to fee_structures_path, notice:"Data Added successfully!"
        else
            render "new", alert:"Enter Correct details!!!"
        end
    end
    def destroy
        @fee_structure = FeeStructure.find(params[:id])
        if @fee_structure.destroy
            redirect_to fee_structures_path, notice:"Data deleted successfully!"
        else 
            render "new", alert:"Something went wrong!"
        end
    end
    
    private
        def fee_structure_params
            params.require(:fee_structure).permit(:admission_fees,:annual_admission_fees,:caution_money,:quarterly_tuition_fees,:id_card_fees,:total)
        end
end
