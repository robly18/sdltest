import state;
import button;
import spritesheet;
import game;
import menu;

class ReplayState : State {
	this(Game prevs, int winner) {
		tmp_txt = new Spritesheet("texture.png");
	
		bback = new SpriteButton(SDL_Rect(36,30+34,32,32), tmp_txt.makeSprite(64,0,32,32),
			tmp_txt.makeSprite(64,32,32,32), tmp_txt.makeSprite(0, 64, 32, 32), delegate {quit = true;});
		breplay = new SpriteButton(SDL_Rect(36+32,30+34,32,32), tmp_txt.makeSprite(64,0,32,32),
			tmp_txt.makeSprite(64,32,32,32), tmp_txt.makeSprite(32, 64, 32, 32), delegate {replay = true; previousState.resetBoard();});
		bg = tmp_txt.makeSprite(64, 64, 64, 32);
		txt = tmp_txt.makeSprite(64+32, 64+32, 32, 32);
		ws = tmp_txt.makeSprite(winnerRect(winner));
		
		previousState = prevs;
	}

	override State tick() {
		if (quit) return new MainMenu;
		if (replay) return previousState;
		return this;
		
	}
	override void render(SDL_Surface* surface) {
		previousState.render(surface);
	
		bback.render(surface);
		breplay.render(surface);
		bg.render(surface, SDL_Rect(36, 30, 64, 32));
		txt.render(surface, SDL_Rect(36+32, 30, 32, 32));
		ws.render(surface, SDL_Rect(36, 30, 32, 32));
	}
	override void handleEvent(ref const SDL_Event e) {
		if (e.type == SDL_MOUSEBUTTONUP) {
			bback.checkEvent(e.button.x, e.button.y, e.button.button);
			breplay.checkEvent(e.button.x, e.button.y, e.button.button);
		}
	}

private:
	SDL_Rect winnerRect(int w) {
		switch (w) {
			case 0:
				return SDL_Rect(0, 96, 32, 32);
			case 1:
				return SDL_Rect(32, 96, 32, 32);
			default:
				return SDL_Rect(64, 96, 32, 32);
		}
	}

	Button bback, breplay;
	Sprite bg, txt, ws;
	
	Spritesheet tmp_txt;
	
	Game previousState;
	bool quit = false;
	bool replay = false;
}