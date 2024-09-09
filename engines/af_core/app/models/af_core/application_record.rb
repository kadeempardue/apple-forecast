# frozen_string_literal: true

module AfCore
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
