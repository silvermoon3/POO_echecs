package ca.uqac.inf957.chess.piece;

import ca.uqac.inf957.chess.agent.Move;
import ca.uqac.inf957.chess.agent.Player;

public class Pawn extends Piece {

    public Pawn(int player) {
	super(player);
    }

    @Override
    public String toString() {
	return ((this.player == Player.WHITE) ? "P" : "p");
    }

    @Override
    public boolean isMoveLegal(Move mv) {
    	boolean special = false;
    	// player1
    			if (player == Player.BLACK) {
    				if ((Math.abs(mv.xF - mv.xI) == 0) && (Math.abs(mv.yF - mv.yI) < 3)) {
    					special = true;
    				}
    				return (((Math.abs(mv.xF - mv.xI) <= 1) && (mv.yF - mv.yI) == -1)) || special;
    			}
    			// player 2
    			
    			if ((Math.abs(mv.xF - mv.xI) == 0) && (Math.abs(mv.yF - mv.yI) < 3)) {
    				special = true;
    			}
    			return (((Math.abs(mv.xF - mv.xI) <= 1) && (mv.yF - mv.yI) == 1)) || special;

	    }
    
    public String getType() {
    	return "Pawn";
    }

}
