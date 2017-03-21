import state;
import game;
import spritesheet;
import button;
import constants;


import ai;

class MainMenu : State {
	this() {
		tmp_txt = new Spritesheet("texture.png");
		bplay = new SpriteButton(SDL_Rect(SW/2 - 32, 10,64,32), tmp_txt.makeSprite(SDL_Rect(0,0,64,32)),
				tmp_txt.makeSprite(SDL_Rect(0,32,64,32)), tmp_txt.makeSprite(SDL_Rect(0, 128, 64, 32)),
				delegate {play = true;});
		bpve = new SpriteButton(SDL_Rect(SW/2 - 32, 10 + 32 + 10,64,32), tmp_txt.makeSprite(SDL_Rect(0,0,64,32)),
				tmp_txt.makeSprite(SDL_Rect(0,32,64,32)), tmp_txt.makeSprite(SDL_Rect(64, 128, 64, 32)),
				delegate {play = true; ai = true;});
		bquit = new SpriteButton(SDL_Rect(SW/2 - 32, 10 + 32 + 10 + 32 + 10,64,32), tmp_txt.makeSprite(SDL_Rect(0,0,64,32)),
				tmp_txt.makeSprite(SDL_Rect(0,32,64,32)), tmp_txt.makeSprite(SDL_Rect(0, 128+32, 64, 32)),
				delegate {quit = true;});
	}
	override State tick() {
		if (quit) return null;
		if (play) return new Game(ai ? new RandomAI : null);
		return this;
	}
	override void render(SDL_Surface* surface) {
		SDL_FillRect(surface, null, 0xFFFFFF);
		bplay.render(surface);
		bpve.render(surface);
		bquit.render(surface);
	}
	override void handleEvent(ref const SDL_Event e) {
		if (e.type == SDL_MOUSEBUTTONUP) {
			bquit.checkEvent(e.button.x, e.button.y, e.button.button);
			bplay.checkEvent(e.button.x, e.button.y, e.button.button);
			bpve.checkEvent(e.button.x, e.button.y, e.button.button);
		}
	}

private:
	Button bplay, bquit, bpve;
	bool quit, play, ai;
	Spritesheet tmp_txt;
}