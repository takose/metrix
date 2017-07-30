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

    before do
      @sum_metrix = MetrixService.prod(metrix_a, metrix_c)
    end

    it 'calculate prod certainly' do
      answer = [
        [1, 8, -14],
        [2, 13, -20],
        [4, 17, -16],
        [1, 17, -26]
      ]
      expect(@sum_metrix.c.transpose).to eq(answer)
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
  end
end
