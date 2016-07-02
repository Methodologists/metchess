require 'rails_helper'

RSpec.describe Knight, type: :model do

  describe "#valid_move?" do

    let(:knight) { Knight.create(x_cord: starting_x, y_cord: starting_y) }

    {
      [-1, -1] => false,
      [0, 8] => false,
    }.each do |coords, result|
      it "returns #{result} when given #{coords}" do
        expect(knight.valid_move?(*coords)).to eq result
      end
    end

    {
      [1, 2] => true,
      [2, 1] => true,
      [1, 1] => false,
    }.each do |change_in_coords, result|
      it "returns #{result} when coordinates change by #{change_in_coords}" do
        expect(knight.valid_move?(
          knight.x_cord + change_in_coords.first,
          knight.y_cord + change_in_coords.last
        )).to eq result
      end
    end


    [
      [1, -2],
      [-1, -2],
    ].each do |change_in_coords|
      it "returns false when given #{change_in_coords} because coordinates are off-board" do
        expect(knight.valid_move?(
          knight.x_cord + change_in_coords.first,
          knight.y_cord + change_in_coords.last
        )).to eq false
      end
    end

    # {
    #   [[0, 0], [5, 3]] => true,
    #   [[0, 0], [6, 2]] => true,
    #   [[0, 0], [5, 2]] => false,

    #   [[3, 3], [2, 1]] => true,
    # }.each do |before_and_after_coords, result|
    #   it "returns #{result} when moving from #{before_and_after_coords.first} to #{before_and_after_coords.last}"
    # end
  end
end
