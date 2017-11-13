package ca.uqac.inf957.chess.piece;

import ca.uqac.inf957.chess.agent.Move;
import ca.uqac.inf957.chess.agent.Player;
import ca.uqac.inf957.chess.piece.Bishop; 
import ca.uqac.inf957.chess.piece.Rook; 


public class Queen extends Piece {

    public Queen(int player) {
	super(player);
    }

    @Override
    public String toString() {
	return ((this.player == Player.WHITE) ? "D" : "d");
    }

    @Override
    public boolean isMoveLegal(Move mv) {
    	Bishop b = new Bishop();
    	Rook r = new Rook();		
		return r.isMoveLegal(mv) || b.isMoveLegal(mv);
    }
    
    public String getType() {
    	return "Queen";
    }
}