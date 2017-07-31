require 'rails_helper'

RSpec.describe MetrixService do
  describe 'calculate' do
    let (:metrix_a) { MetrixService.new(
      [
        [1, 2, 3],
        [2, 3, 4],
        [4, 3, 2],
        [1, 5, 3]
      ]
    )}

    let (:metrix_b) { MetrixService.new(
      [
        [-1, -2, 3],
        [0, 3, 1],
        [-4, -3, -2],
        [3, 2, -1]
      ]
    )}

    let (:metrix_c) { MetrixService.new(
      [
        [1, 2, 0],
        [0, 3, -4],
        [0, 0, -2]
      ]
    )}

    let (:metrix_d) { MetrixService.new(
      [
        [1, 2]
      ]
    )}

    before do
      @prod_metrix = MetrixService.prod(metrix_a, metrix_c)
      @sum_metrix = MetrixService.sum(metrix_a, metrix_b)
    end

    it 'calculate prod certainly' do
      answer = [
        [1, 8, -14],
        [2, 13, -20],
        [4, 17, -16],
        [1, 17, -26]
      ]
      expect(@prod_metrix.c.transpose).to eq(answer)
    end

    it 'calculate sum certainly' do
      answer = [
        [0, 0, 6],
        [2, 6, 5],
        [0, 0, 0],
        [4, 7, 2]
      ]
      expect(@sum_metrix.c.transpose).to eq(answer)
    end

    it 'calculate tr certainly' do
      answer = 2
      expect(metrix_c.tr).to eq(answer)
    end

    it 'calculate det certainly' do
      answer = -6
      expect(metrix_c.det).to eq(answer)
    end

    it "can'tcalculate tr certainly" do
      expect(metrix_a.tr.error).to eq('行列のサイズが正しくありません')
    end

    it "can'tcalculate det certainly" do
      expect(metrix_a.det.error).to eq('行列のサイズが正しくありません')
    end

    it "can't calculate with different size metrixes" do
      error_metrix = MetrixService.prod(metrix_a, metrix_d)
      expect(error_metrix.error).to eq("行列のサイズが正しくありません")
    end

    it "can't calculate with different size metrixes" do
      error_metrix = MetrixService.sum(metrix_a, metrix_d)
      expect(error_metrix.error).to eq("行列のサイズが正しくありません")
    end
  end
end
