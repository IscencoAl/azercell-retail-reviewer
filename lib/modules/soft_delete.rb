module Modules::SoftDelete
  extend ActiveSupport::Concern
  
  included do
    define_model_callbacks :soft_delete
    define_model_callbacks :restore
    default_scope { where(:is_deleted => false) }
  end
  
  module ClassMethods
    def deleted
      unscoped.where(:is_deleted => true)
    end
  end
  
  def soft_delete
    run_callbacks :soft_delete do
      update_attribute(:is_deleted, true)
    end
  end
  
  def restore
    run_callbacks :restore do 
      self.class.unscoped do
        update_attribute(:is_deleted, false)
      end
    end
  end
end