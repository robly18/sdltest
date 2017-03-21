import game;
import std.random;

class AI {
	abstract void play(Game game);
}

class RandomAI : AI {
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