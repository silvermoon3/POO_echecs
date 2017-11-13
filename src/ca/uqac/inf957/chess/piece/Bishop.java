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
    	float x = mv.xI - mv.xF;
		float y = mv.yI - mv.yF;
		if (x == 0) {
			return false;
		}
		return Math.abs(y / x) == 1.0;	
    }
    
    public String getType() {
    	return "Bishop";
    }
}
