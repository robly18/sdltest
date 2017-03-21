import state;
import button;
import spritesheet;
import constants;

import replayState;

import ai;


class Game : State {
	this(AI ai_ = null) {
		tmp_txt = new Spritesheet("texture.png");
		
		for (int x = 0; x != 3; x++)
		for (int y = 0; y != 3; y++) {
			boardState[x][y] = -1;
			board[x][y] = new Button(SDL_Rect(10 + 42*x, 10 + 42*y, 32, 32), tmp_txt.makeSprite(64,0,32,32), tmp_txt.makeSprite(64,32,32,32), act(x,y));
		}
		ai = ai_;
	}

	override State tick() {
		if (!nextState) return this;
		return nextState;
	}
	override void render(SDL_Surface* surface) {
		SDL_FillRect(surface, null, 0xFFFFFF);
		for (int x = 0; x != 3; x++)
		for (int y = 0; y != 3; y++) {
			board[x][y].render(surface);
		}
	}
	override void handleEvent(ref const SDL_Event e) {
		if (e.type == SDL_MOUSEBUTTONUP) {
			for (int x = 0; x != 3; x++)
			for (int y = 0; y != 3; y++) {
				board[x][y].checkEvent(e.button.x, e.button.y, e.button.button);
			}
		}
	}
	
	void resetBoard() {
		state = 1;
		for (int x = 0; x != 3; x++)
		for (int y = 0; y != 3; y++) {
			boardState[x][y] = -1;
			board[x][y] = new Button(SDL_Rect(10 + 42*x, 10 + 42*y, 32, 32), tmp_txt.makeSprite(64,0,32,32), tmp_txt.makeSprite(64,32,32,32), act(x,y));
		}
		plays = 0;
		nextState = null;
	}
	
	Button[3][3] board;
	int[3][3] boardState;
	
private:

	bool checkWin(int who, int x, int y) {
		auto bs = boardState;
		if (x == y) {
			if (bs[0][0] == who && bs[1][1] == who && bs[2][2] == who) return true;
		}
		if (x == 2-y) {
			if (bs[0][2] == who && bs[1][1] == who && bs[2][0] == who) return true;
		}
		if (bs[x][0] == who && bs[x][1] == who && bs[x][2] == who) return true;
		if (bs[0][y] == who && bs[1][y] == who && bs[2][y] == who) return true;
		return false;
	}
	
	void delegate() act(int x, int y) {
		void f () {
			board[x][y] = new Button(SDL_Rect(10+42*x, 10+42*y, 32, 32), tmp_txt.makeSprite(96+state*32, 0, 32, 32), tmp_txt.makeSprite(96+state*32, 32, 32, 32));
			boardState[x][y] = state;
			plays++;
			
			if (checkWin(state, x, y)) {
				nextState = new ReplayState(this, state);
			} else if (plays == 9) {
				nextState = new ReplayState(this, -1);
			} else {
				state = 1 - state;
				if (ai && state == aiturn) {
					ai.play(this);
				}
			}
		}
		return &f;
	}
	

	int plays = 0;
	int state = 1;
	
	Spritesheet tmp_txt;
	
	State nextState = null;
	
	AI ai = null;
	int aiturn = 0;
}