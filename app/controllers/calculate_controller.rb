class CalculateController < ApplicationController
  before_action :set_metrix, only: [:sum, :prod]
  def index
  end

  def sum
    sum_metrix = MetrixService.sum(@metrix_a, @metrix_b)
    if sum_metrix.error
      @error = sum_metrix.error
    else
      @sum = sum_metrix.c.transpose
    end
    render :index
  end

  def prod
    prod_metrix = MetrixService.prod(@metrix_a, @metrix_b)
    if prod_metrix.error
      @error = prod_metrix.error
    else
      @prod = prod_metrix.c.transpose
      p @prod
    end
    render :index
  end

  private

  def set_metrix
    @metrix_a = MetrixService.new(build_metrix(params[:metrix_a]))
    @metrix_b = MetrixService.new(build_metrix(params[:metrix_b]))
  end

  def build_metrix(_metrix)
    metrix = []
    _metrix.split("\r\n").each do |row|
      metrix << row.split(' ').map(&:to_i)
    end
    metrix
  end
end
