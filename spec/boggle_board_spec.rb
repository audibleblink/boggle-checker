require_relative '../boggle_board'
require_relative '../lib/die_factory'

describe BoggleBoard do

  let(:dice)  { DieFactory.create("./lib/dice_definitions.txt") }
  let(:board) { BoggleBoard.new(dice) }

  context "#coords_to_index" do
    it "converts 4x4 matrix coordinates to 16-length array index" do
      expect(board.send :coords_to_index, [2,2]).to eq 10
      expect(board.send :coords_to_index, [0,0]).to eq 0
    end
  end

  context "#surrounding_coords_for" do
    it "returns an array of surrounding coordinates" do
      expect(board.send :surrounding_coords_for, [0,0])
        .to eq [[0,1],[1,0],[1,1]]
    end
  end

  context "#valid_coordinates?" do
    it "return true given valid coordinates" do
      expect(board.send :valid_coordinates?, [3,3]).to be true
    end

    it "return false given invalid coordinates" do
      expect(board.send :valid_coordinates?, [-1,0]).to be false
      expect(board.send :valid_coordinates?, [0,4] ).to be false
    end
  end

  context "#neighboring_indices_for" do
  it "returns an array of neighboring_indices_for a given index" do
    allow(board)
      .to receive(:surrounding_coords_for)
      .and_return([[0,1], [1,0], [1,1]])

    expect(board.send :neighboring_indices_for, 0)
      .to include(1,4,5)
    end
  end
end
