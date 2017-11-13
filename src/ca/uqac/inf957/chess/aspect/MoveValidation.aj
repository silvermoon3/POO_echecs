package ca.uqac.inf957.chess.aspect;

import ca.uqac.inf957.chess.Board;
import ca.uqac.inf957.chess.agent.*;
import ca.uqac.inf957.chess.piece.Piece;



public aspect MoveValidation {

	
	pointcut Check(Move mv): call(boolean Player.move(Move))
		&& args(.., mv)
		&& target(Player)
		&& !within(MoveValidation);
	
	boolean around(Move mv): Check (mv){
		Player p = (Player) thisJoinPoint.getTarget();
		Board b = p.getPlayGround();
		return checkMove(b, mv, p); 
	}
	
	protected static boolean checkMove(Board b, Move mv, Player p){
		
		boolean moveValid  = false;
		try {
			moveValid = (mv != null);
			moveValid = moveValid && b.getGrid()[mv.xI][mv.yI].isOccupied();
			moveValid = moveValid && b.getGrid()[mv.xI][mv.yI].getPiece().getPlayer() == p.getColor();
			moveValid = moveValid && b.getGrid()[mv.xI][mv.yI].getPiece().isMoveLegal(mv);
			if (moveValid && b.getGrid()[mv.xF][mv.yF].isOccupied()) {
				moveValid = moveValid && b.getGrid()[mv.xF][mv.yF].getPiece().getPlayer() != p.getColor();
			}
		} catch (ArrayIndexOutOfBoundsException e) {
			moveValid = false;
		}

		if(moveValid) {		
			Piece piece = b.getGrid()[mv.xI][mv.yI].getPiece();
			switch(piece.getType()) {
				case "Bishop" : moveValid =  checkBishop(b, mv, piece.getPlayer());
				break;
				case "King" : moveValid =  checkKing(b, mv, piece.getPlayer());
				break;
				case "Knight" : moveValid =  checkKnight(b,mv,piece.getPlayer());
				break;
				case "Pawn" : moveValid =  checkPawn(b,mv,piece.getPlayer());
				break;
				case "Queen" : moveValid =  checkQueen(b, mv, piece.getPlayer());
				break;
				case "Rook" : moveValid=  checkRook(b,mv,piece.getPlayer());
				break;
			}
		}
		if(moveValid)
			b.movePiece(mv);
		return moveValid;			
	
	}
	
	private static boolean checkQueen(Board b, Move mv, int p) {
		if(mv.xF == mv.xI || mv.yF == mv.yI){
			return checkRook(b, mv, p);
		} else {
			return checkBishop(b, mv, p);
		}
	}
	
	
	private static boolean checkRook(Board b, Move mv, int p) {
		
		//On ne mange pas nos prores pièces
		if(b.getGrid()[mv.xF][mv.yF].isOccupied())
			if(b.getGrid()[mv.xF][mv.yF].getPiece().getPlayer() == p)
				return false;
		
		
		//si on se déplace selon les y
		if(mv.xF == mv.xI){
			//Si y final > y initial
			if(mv.yF > mv.yI)
			{
				//On regarde si il y a une pièce sur la trajectoire				
				for(int i = mv.yI + 1; i < mv.yF; i++)
				{
					if(b.getGrid()[mv.xF][i].isOccupied())
					{
						
						return false;
					}
				}
			} 
			else
			{				
				for(int i = mv.yI - 1; i > mv.yF; i--)
				{
					if(b.getGrid()[mv.xF][i].isOccupied())
					{
						return false;
					}
				}
			}
		} 
		//Si on se déplace selon les x
		else 
		{
			if(mv.xF > mv.xI) 
			{
				for(int i = mv.xI + 1; i < mv.xF; i++) 
				{
					if(b.getGrid()[i][mv.yF].isOccupied())
					{
						return false;
					}
				}
			}
			else
			{
				for(int i = mv.xI - 1; i > mv.xF; i--)
				{
					if(b.getGrid()[i][mv.yF].isOccupied())
					{
						return false;
					}
				}
			}
		}
	
		return true;
	}

	

	private static boolean checkKnight(Board b, Move mv, int p) {
		
		//Ne peut pas manger ses propres pions
		if(b.getGrid()[mv.xF][mv.yF].isOccupied())
			if(b.getGrid()[mv.xF][mv.yF].getPiece().getPlayer() == p)
			return false;
		
		
		return true;
	}


	private static boolean checkBishop(Board b, Move mv, int p) {
		
		//Ne peut pas manger ses propres pions
		if(b.getGrid()[mv.xF][mv.yF].isOccupied())
			if(b.getGrid()[mv.xF][mv.yF].getPiece().getPlayer() == p)
			return false;
		
		//En bas à gauche
		if(mv.xF < mv.xI && mv.yF < mv.yI  )
		{
			for(int i = 1; i < mv.yI - mv.yF; i++)
			{
				if(mv.xI-i > -1 && b.getGrid()[mv.xI - i][mv.yI - i].isOccupied())
				{
					return false;
				}
			}
		} 
	
		//En haut à droite
		if(mv.xF > mv.xI && mv.yF > mv.yI )
		{
			for(int i = 1; i < mv.yF - mv.yI; i++)
			{
				if(mv.xI+i < Board.SIZE && b.getGrid()[mv.xI + i][mv.yI + i].isOccupied()){
					return false;
				}
			}
		} 
	
		//En bas à droite 		
		if( mv.xF > mv.xI && mv.yF < mv.yI )
		{
			for(int i = 1; i < mv.yI - mv.yF; i++)
			{
				if(mv.xI+i < Board.SIZE && b.getGrid()[mv.xI + i][mv.yI - i].isOccupied()){
					return false;
				}
			}
		} 
		
		//En haut à gauche 
		if( mv.xF < mv.xI && mv.yF > mv.yI)
		{
			for(int i = 1; i < mv.yF - mv.yI; i++)
			{
				if(mv.xI-i > -1 && b.getGrid()[mv.xI - i][mv.yI + i].isOccupied()){
					return false;
				}
			}
		} 		
	
		return true;
	}
	
	private static boolean checkKing(Board b, Move mv, int p) 
	{
		//Ne peut pas manger ses propres pions
		if(b.getGrid()[mv.xF][mv.yF].isOccupied())
			if (b.getGrid()[mv.xF][mv.yF].getPiece().getPlayer() == p)
			return false;	
		
		return true;
	}

	private static boolean checkPawn(Board b, Move mv, int p) 
	{					
		//Joueur noir
		if(p == Player.WHITE)
		{			
			//Pas de retour arriere
			if(mv.yF <= mv.yI)
			{
				return false;
			}
			//2 déplacements au départ
			if(mv.yI != 1)
			{
				if(mv.yF > mv.yI + 1)
				{
					return false;
				} 				
			}
			//Gestion pour manger une pièce adverse 
			if(b.getGrid()[mv.xF][mv.yF].isOccupied())
			{
				//Impossible de manger tout droit
				if (mv.xF == mv.xI)
				{
					return false;
				}
				
				//Ne mange pas ses propres pieces
				else if(b.getGrid()[mv.xF][mv.yF].getPiece().getPlayer() == Player.WHITE)
				{
					return false;
				} 
				
			}
			
			else if(mv.xF != mv.xI)
			{
				return false;
			}
		
			return true;
				
		} 
		else 
		{			
			//Pas de retour arriere
			if(mv.yF >= mv.yI)
			{
				return false;
			}
			
			//Au départ on peut déplacer de deux cases
			if(mv.yI != 6)
			{
				if(mv.yF < mv.yI - 1)
				{
					return false;
				} 				
			}
			
			//Gestion pour manger une pièce adverse 
			if(b.getGrid()[mv.xF][mv.yF].isOccupied())
			{						
				//Ne mange pas tout droit
				if (mv.xF == mv.xI)
				{
					return false;
				}
				//Ne peut pas manger ses propres pièces
				else if(b.getGrid()[mv.xF][mv.yF].getPiece().getPlayer() == Player.BLACK)
				{
					return false;
				} 
			}
			
			else if(mv.xF != mv.xI)
			{
				return false;
			}
			
			return true;
		}
		
	}
	
}

