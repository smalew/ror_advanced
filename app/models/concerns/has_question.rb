module HasQuestion
  extend ActiveSupport::Concern

  included do
    belongs_to :question
  end
end
