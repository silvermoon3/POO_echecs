//A faire par Elie 
package ca.uqac.inf957.chess.aspect;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;

import ca.uqac.inf957.chess.agent.*;
import ca.uqac.inf957.chess.agent.Move;
import ca.uqac.inf957.chess.*;


public aspect LogMovement 
{
	
pointcut newGame() : call (* Game.play()) && target(Game);
pointcut logMovement(Move m) : call (void Board.movePiece(Move)) && args(m);

	before()  : newGame(){
		try {
			Files.deleteIfExists(Paths.get("logMovement.txt"));
		//	Files.createFile(Paths.get(filename));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	after(Move m)  : logMovement(m)
	{
		
		File f = new File("logMovement.txt");
		
		FileWriter fw;
		try {
			
			fw = new FileWriter(f, true);			
			fw.write("Coup:" + m.toString() + System.getProperty("line.separator"));
			fw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
}
