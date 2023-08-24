# frozen_string_literal: true

# This is create notification migration
class AddNotNullToTables < ActiveRecord::Migration[6.1]
  TABLE_COLUMNS = [
    [:admins, %i[email password_digest]],
    [:age_criteria, %i[date_of_birth_after date_of_birth_before age date_as_on]],
    [:class_categories, %i[classname]],
    [:fee_structures, %i[admission_fees annual_admission_fees caution_money quarterly_tuition_fees id_card_fees total]],
    [:invitations, %i[email token expires_at]],
    [:notifications, %i[recipient_id sender_id message read_status]],
    [:payments, %i[mode_of_payment amount status]],
    [:sections, %i[section]],
    [:students, %i[name email date_of_birth age academic_year father_name mother_name address contact_number]]
  ].freeze

  def change
    TABLE_COLUMNS.each do |table, columns|
      columns.each do |column|
        change_column_null table, column, false
      end
    end
  end
end
