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
    	boolean first = false;
    	
    	if (player == Player.BLACK) 
    	{
    		if ((Math.abs(mv.xF - mv.xI) == 0) && (Math.abs(mv.yF - mv.yI) < 3)) 
    		{
    				first = true;
    		}    				
    				
    		return (((Math.abs(mv.xF - mv.xI) <= 1) && (mv.yF - mv.yI) == -1)) || first;
    	}
    			
    	if ((Math.abs(mv.xF - mv.xI) == 0) && (Math.abs(mv.yF - mv.yI) < 3))    	
    	{
    				first = true;
    	}    			
    	return (((Math.abs(mv.xF - mv.xI) <= 1) && (mv.yF - mv.yI) == 1)) || first;

    }
    
    public String getType() {
    	return "Pawn";
    }

}
