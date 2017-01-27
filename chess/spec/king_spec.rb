require_relative "../chess.rb"

RSpec.describe King do
  let(:game) {Game.new}
  let(:board) {game.empty_board}
  let(:cen_king) {board[35] = King.new("white", "e4")}
  let(:cor_king) {board[0] = King.new("white", "a1")}

  describe "#move" do
    it "moves one space in a column (u)" do
      cen_king.move(board, "f4")
      expect(board[43].position).to eq("f4")
    end

    it "moves one space in a column (d)" do
      cen_king.move(board, "d4")
      expect(board[27].position).to eq("d4")
    end

    it "doesn't move more than space in a column" do
      cen_king.move(board, "g4")
      expect(board[51]).to eq(nil)
    end

    it "moves one space in a row (r)" do
      cen_king.move(board, "e5")
      expect(board[36].position).to eq("e5")
    end

    it "moves one space in a row (l)" do
      cen_king.move(board, "e3")
      expect(board[34].position).to eq("e3")
    end

    it "doesn't move more than space in a row" do
      cen_king.move(board, "e6")
      expect(board[37]).to eq(nil)
    end

    it "moves one space diagonally (ur)" do
      cen_king.move(board, "f5")
      expect(board[44].position).to eq("f5")
    end

    it "moves one space diagonally (ul)" do
      cen_king.move(board, "f3")
      expect(board[42].position).to eq("f3")
    end

    it "moves one space diagonally (dr)" do
      cen_king.move(board, "d5")
      expect(board[28].position).to eq("d5")
    end

    it "moves one space diagonally (dl)" do
      cen_king.move(board, "d3")
      expect(board[26].position).to eq("d3")
    end

    it "doesn't move more than space diagonally" do
      cen_king.move(board, "g6")
      expect(board[53]).to eq(nil)
    end

    it "doesn't move if moving into check" do
      board[60] = Rook.new("black", "h5")
      cen_king.move(board, "e5")
      expect(board[36]).to eq(nil)
    end
  end

  describe "#create_diagonals" do
    it "returns an array of all diagonal spots from a center spot" do
      expect(cen_king.create_diagonals(cen_king.position)).to eq(["a8", "b1", "b7", "c2",
                                                     "c6", "d3", "d5", "f3",
                                                     "f5", "g2", "g6", "h1",
                                                     "h7"])
    end

    it "returns an array of all diagonal spots from a corner spot" do
      expect(cor_king.create_diagonals(cor_king.position)).to eq(["b2", "c3", "d4", "e5",
                                                      "f6", "g7", "h8"])
    end
  end

  describe "#create_row" do
    it "returns an array of all the row and column spots from center spot" do
      expect(cen_king.create_row(cen_king.position)).to eq(["e1", "e2", "e3", "e5",
                                         "e6", "e7", "e8"])
    end

    it "returns an array of all the row and column spots from center spot" do
      expect(cor_king.create_row(cor_king.position)).to eq(["a2", "a3", "a4",
                                         "a5", "a6", "a7",
                                         "a8"])
    end
  end

  describe "#create_column" do
    it "returns an array of all the row and column spots from center spot" do
      expect(cen_king.create_column(cen_king.position)).to eq(["a4", "b4", "c4",
                                            "d4", "f4",
                                            "g4", "h4"])
    end

    it "returns an array of all the row and column spots from center spot" do
      expect(cor_king.create_column(cor_king.position)).to eq(["b1", "c1",
                                            "d1", "e1", "f1",
                                            "g1", "h1"])
    end
  end

  describe "#create_l_move" do
    it "returns an array of all the row and column spots from center spot" do
      expect(cen_king.create_l_move(cen_king.position)).to eq(["c3", "c5", "d2",
                                                          "d6", "f2", "f6",
                                                          "g3", "g5"])
    end

    it "returns an array of all the row and column spots from center spot" do
      expect(cor_king.create_l_move(cor_king.position)).to eq(["b3", "c2"])
    end
  end

  describe "#check?" do
    it "returns true if a knight is attacking" do
      board[52] = Knight.new("black", "g5")
      expect(cen_king.check?(board, cen_king.position)).to eq(true)
    end

    it "returns true if a rook is attacking in a row" do
      board[39] = Rook.new("black", "e8")
      expect(cen_king.check?(board, cen_king.position)).to eq(true)
    end

    it "returns true if a queen is attacking in a row" do
      board[39] = Queen.new("black", "e8")
      expect(cen_king.check?(board, cen_king.position)).to eq(true)
    end

    it "returns true if a rook is attacking in a column" do
      board[59] = Rook.new("black", "h4")
      expect(cen_king.check?(board, cen_king.position)).to eq(true)
    end

    it "returns true if a queen is attacking in a column" do
      board[59] = Queen.new("black", "h4")
      expect(cen_king.check?(board, cen_king.position)).to eq(true)
    end

    it "returns true if a bishop is attacking diagonally" do
      board[8] = Bishop.new("black", "b1")
      expect(cen_king.check?(board, cen_king.position)).to eq(true)
    end

    it "returns true if a queen is attacking diagonally" do
      board[8] = Queen.new("black", "b1")
      expect(cen_king.check?(board, cen_king.position)).to eq(true)
    end

    it "returns true if a pawn is attacking" do
      board[42] = Pawn.new("black", "f3")
      expect(cen_king.check?(board, cen_king.position)).to eq(true)
    end

    it "returns false if is is not in check" do
      expect(cen_king.check?(board, cen_king.position)).to eq(false)
    end
  end

  describe "#diagonally_attacked" do
    it "returns true if there are pieces attacking the space" do
      board[53] = Bishop.new("black", "g6")
      expect(cen_king.diagonally_attacked?(board, cen_king.position)).to eq(true)
    end

    it "returns false if there aren't any pieces attacking the space" do
      expect(cen_king.diagonally_attacked?(board, cen_king.position)).to eq(false)
    end
  end
end
