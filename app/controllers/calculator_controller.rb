class String
  def calculate
    [:+, :-, :*, :/].each do |operator|
      expression = self.split(operator.to_s)
      next unless expression.size > 1

      return expression.map(&:calculate).inject(operator)
    end
    to_f
  end
end

class CalculatorController < ApplicationController
  def calculate
    message = if validate_expression
                fix_expression
              else
                'Invalid expression'
              end

    render json: {
      expression: message,
      result: validate_expression ? fix_expression.to_s.calculate : nil,
    }, status: :ok
  end

  private
  
  def expression_params
    params.permit(:expression)
  end

  def fix_expression
    expression_params[:expression].gsub(' ', '+')
  end

  def validate_expression
    fix_expression =~ /^([-+]? ?(\d+|\(\g<1>\))( ?[-+*\/] ?\g<1>)?)$/
  end
end