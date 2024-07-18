module Api::BudgetsHelper
  module Errors
    def correct_format_for_order?(by_param, direction_param)
      return true if by_param.nil? && direction_param.nil?

      return false unless Budget.has_attribute?(by_param)

      return false unless %w[asc desc ASC DESC].any?(direction_param)

      true
    end

    def correct_format_for_limit?(limit_param)
      return true if limit_param.nil?

      return false unless limit_param.match?(/\A\d+\z/)

      true
    end
  end
end
