import game;
import std.random;

class AI {
	this(int w) {
		who = w;
	}
	abstract void play(Game game);
	
	int who;
}

class RandomAI : AI {
	this (int w) {super(w);}
	override void play(Game game) {
		//assuming game is not a draw -- that would make infinite loop!
		int x = uniform(0, 3);
		int y = uniform(0, 3);
		if (game.boardState[x][y] == -1) {
			game.board[x][y].action();
		} else {
			play(game);
		}
	}
}

class MediumAI : AI {
	this (int w) {super(w);}
	override void play(Game game) {
		int[3] xs = [0,1,2];
		int[3] ys = [0,1,2];
		randomShuffle(xs[]); randomShuffle(ys[]);
		
		foreach (int x; xs)
		foreach (int y; ys) {
			if (game.boardState[x][y] == -1 && wouldWin(game.boardState,x,y,who)) {
				game.board[x][y].action();
				return;
			}
		}
		foreach (int x; xs)
		foreach (int y; ys) {
			if (game.boardState[x][y] == -1 && wouldWin(game.boardState,x,y,1-who)) {
				game.board[x][y].action();
				return;
			}
		}
		foreach (int x; xs)
		foreach (int y; ys) {
			if (game.boardState[x][y] == -1) {
				game.board[x][y].action();
				return;
			}
		}
		assert(false);
	}
	
	bool wouldWin(int[3][3] board, int x, int y, int who) {
		board[x][y] = who;
		return boardWon(board, x, y, who);
	}
}