class EmploymentsController < ApplicationController
  def index
    @employments = Employment.all
  end
end
