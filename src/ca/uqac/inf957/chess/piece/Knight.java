package ca.uqac.inf957.chess.piece;

import ca.uqac.inf957.chess.agent.Move;
import ca.uqac.inf957.chess.agent.Player;

public class Knight extends Piece {

    public Knight(int player) {
	super(player);
    }

    @Override
    public String toString() {
	return ((this.player == Player.WHITE) ? "C" : "c");
    }

    @Override
    public boolean isMoveLegal(Move mv) {
    	if (Math.abs(mv.xI - mv.xF) == 2)     	
			return Math.abs((mv.yI - mv.yF)) == 1;
    	
		else if (Math.abs(mv.xI - mv.xF) == 1) 
			return Math.abs((mv.yI - mv.yF)) == 2;
		
		return false;
	}
    
    public String getType() {
    	return "Knight";
    }
}