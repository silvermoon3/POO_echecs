package ca.uqac.inf957.chess.piece;

import ca.uqac.inf957.chess.agent.Move;
import ca.uqac.inf957.chess.agent.Player;

public class Bishop extends Piece {

    public Bishop(int player) {
	super(player);
    }

    public Bishop() {
    }

    @Override
    public String toString() {
	return ((this.player == Player.WHITE) ? "B" : "b");
    }

    @Override
    public boolean isMoveLegal(Move mv) {
    	return false;
    }
}
