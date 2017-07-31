class CalculateController < ApplicationController
  before_action :set_metrix, only: [:sum, :prod]
  def index
    @sum_histories = SumHistory.all
    @prod_histories = ProdHistory.all
    @tr_histories = TrHistory.all
    @det_histories = DetHistory.all
  end

  def sum
    unless params[:metrix_a].empty? || params[:metrix_b].empty?
      r = /[^\d||\s||[-]]/
      if r.match(params[:metrix_a]) || r.match(params[:metrix_b])
        @error = '書式が正しくありません'
      else
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
      end
    else
      @error = '行列を入力してください'
    end
    @sum_histories = SumHistory.all
    @prod_histories = ProdHistory.all
    @tr_histories = TrHistory.all
    @det_histories = DetHistory.all
    render :index
  end

  def prod
    unless params[:metrix_a].empty? || params[:metrix_b].empty?
      r = /[^\d||\s||[-]]/
      if r.match(params[:metrix_a]) || r.match(params[:metrix_b])
        @error = '書式が正しくありません'
      else
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
      end
    else
      @error = '行列を入力してください'
    end
    @sum_histories = SumHistory.all
    @prod_histories = ProdHistory.all
    @tr_histories = TrHistory.all
    @det_histories = DetHistory.all
    render :index
  end

  def tr
    @metrix = MetrixService.new(build_metrix(params[:metrix]))
    unless params[:metrix].empty?
      r = /[^\d||\s||[-]]/
      if r.match(params[:metrix])
        @error = '書式が正しくありません'
      else
        @tr = @metrix.tr
        if @tr.respond_to?(:error)
          @error = @tr.error
        else
          TrHistory.create(
            metrix: @metrix.build_string,
            result: @tr
          )
        end
      end
    else
      @error = '行列を入力してください'
    end
    @sum_histories = SumHistory.all
    @prod_histories = ProdHistory.all
    @tr_histories = TrHistory.all
    @det_histories = DetHistory.all
    render :index
  end

  def det
    @metrix = MetrixService.new(build_metrix(params[:metrix]))
    unless params[:metrix].empty?
      r = /[^\d||\s||[-]]/
      if r.match(params[:metrix])
        @error = '書式が正しくありません'
      else
        @det = @metrix.det
        if @det.respond_to?(:error)
          @error = @det.error
        else
          DetHistory.create(
            metrix: @metrix.build_string,
            result: @det
          )
        end
      end
    else
      @error = '行列を入力してください'
    end
    @sum_histories = SumHistory.all
    @prod_histories = ProdHistory.all
    @tr_histories = TrHistory.all
    @det_histories = DetHistory.all
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
