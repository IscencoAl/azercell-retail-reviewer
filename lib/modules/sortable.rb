module Modules::Sortable
  extend ActiveSupport::Concern

  module ClassMethods
    def sort(sorting_params)
      self.public_send("by_#{sorting_params[:col]}", sorting_params[:dir]) if sorting_params.present?
    end
  end
end