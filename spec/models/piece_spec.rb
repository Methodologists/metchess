require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "#move_to!" do
    context "when another piece is on the new spot" do
      it "captures an enemy piece on the new spot by updating its coords to nil"
      it "updates the x and y coords of the piece"
      it "does not update own coords if friend piece on the new spot"
    end
    context "when no piece on the new spot" do
      it "updates the x and y coords of the piece"
    end
  end
end