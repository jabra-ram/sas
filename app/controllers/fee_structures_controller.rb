# frozen_string_literal: true

# This is Fee Structure controller
class FeeStructuresController < ApplicationController
  def index
    @fee_structures = FeeStructure.all
  end

  def new
    @fee_structure = FeeStructure.new
  end

  def create
    @fee_structure = FeeStructure.new(fee_structure_params)
    if FeeStructure.exist_for_class_category(params[:fee_structure][:class_category_id]).any?
      flash.now[:alert] = 'Fee Structure already exist for this class!'
      render :new
    elsif @fee_structure.save
      redirect_to fee_structures_path, notice: 'Data Added successfully!'
    else
      render :new
    end
  end

  def edit
    @fee_structure = FeeStructure.find(params[:id])
  end

  def update
    @fee_structure = FeeStructure.find(params[:id])
    if @fee_structure.update(fee_structure_params)
      redirect_to fee_structures_path, notice: 'Data Updated successfully!'
    else
      render :edit
    end
  end

  def destroy
    @fee_structure = FeeStructure.find(params[:id])
    if @fee_structure.destroy
      redirect_to fee_structures_path, notice: 'Data deleted successfully!'
    else
      redirect_to fee_structures_path, alert: 'Something went wrong!'
    end
  end

  private

  def fee_structure_params
    params.require(:fee_structure).permit(:class_category_id, :admission_fees, :annual_admission_fees,
                                          :caution_money, :quarterly_tuition_fees, :id_card_fees, :total)
  end
end
