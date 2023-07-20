# frozen_string_literal: true

# This is student helper
module StudentsHelper
  def attach_documents
    params[:student][:photo] && @student.photo.attach(params[:student][:photo])
    params[:student][:docs] && @student.docs.attach(params[:student][:docs])
  end
end
