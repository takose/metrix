class CalculateController < ApplicationController
  before_action :set_metrix, only: [:sum, :prod]
  def index
    @sum_histories = SumHistory.all
    @prod_histories = ProdHistory.all
  end

  def sum
    sum_metrix = MetrixService.sum(@metrix_a, @metrix_b)
    if sum_metrix.error
      @error = sum_metrix.error
    else
      @sum = sum_metrix.c.transpose
      SumHistory.create(
        metrix_a: @metrix_a.build_string,
        metrix_b: @metrix_b.build_string,
        result: build_string(@sum)
      )
    end
    @sum_histories = SumHistory.all
    @prod_histories = ProdHistory.all
    render :index
  end

  def prod
    prod_metrix = MetrixService.prod(@metrix_a, @metrix_b)
    if prod_metrix.error
      @error = prod_metrix.error
    else
      @prod = prod_metrix.c.transpose
      ProdHistory.create(
        metrix_a: @metrix_a.build_string,
        metrix_b: @metrix_b.build_string,
        result: build_string(@prod)
      )
    end
    @sum_histories = SumHistory.all
    @prod_histories = ProdHistory.all
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

  def build_string(c)
    _ = []
    c.each do |_c|
      _ << _c.join(' ')
    end
    _.join("\r\n")
  end

end
