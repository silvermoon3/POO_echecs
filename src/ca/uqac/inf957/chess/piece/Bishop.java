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
    	float moveX = mv.xI - mv.xF;
		float moveY = mv.yI - mv.yF;
		if (moveX == 0) {
			return false;
		}
		return Math.abs(moveY / moveX) == 1.0;	
    }

}
