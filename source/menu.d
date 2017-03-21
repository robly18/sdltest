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
		if (play) {
			if (!ai) return new Game(null);
			else return new AIMenu;
		}
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

class AIMenu : State {
	this() {
		tmp_txt = new Spritesheet("texture.png");
		bback = new SpriteButton(SDL_Rect(SW/2 - 16, 10 + 32 + 10 + 32 + 10,32,32), tmp_txt.makeSprite(SDL_Rect(64,0,32,32)),
				tmp_txt.makeSprite(SDL_Rect(64,32,32,32)), tmp_txt.makeSprite(SDL_Rect(0, 64, 32, 32)),
				delegate {choice = -1;});
		beasy = new SpriteButton(SDL_Rect(SW/2 - 32 - 5, 10 + 32,32,32), tmp_txt.makeSprite(SDL_Rect(64,0,32,32)),
				tmp_txt.makeSprite(SDL_Rect(64,32,32,32)),  tmp_txt.makeSprite(SDL_Rect(0, 192, 32, 32)),
				delegate {choice = 1;});
		bmedium = new SpriteButton(SDL_Rect(SW/2 + 5, 10 + 32,32,32), tmp_txt.makeSprite(SDL_Rect(64,0,32,32)),
				tmp_txt.makeSprite(SDL_Rect(64,32,32,32)),  tmp_txt.makeSprite(SDL_Rect(32, 192, 32, 32)),
				delegate {choice = 2;});
	}
	override State tick() {
		switch (choice) {
			case 0: return this;
			case -1: return new MainMenu;
			case 1: return new Game(new RandomAI(0));
			case 2: return new Game(new MediumAI(0));
			default: return null;
		}
	}
	override void render(SDL_Surface* surface) {
		SDL_FillRect(surface, null, 0xFFFFFF);
		bback.render(surface);
		beasy.render(surface);
		bmedium.render(surface);
	}
	override void handleEvent(ref const SDL_Event e) {
		if (e.type == SDL_MOUSEBUTTONUP) {
			bback.checkEvent(e.button.x, e.button.y, e.button.button);
			beasy.checkEvent(e.button.x, e.button.y, e.button.button);
			bmedium.checkEvent(e.button.x, e.button.y, e.button.button);
		}
	}

private:
	Button beasy, bmedium, bback;
	int choice = 0; // -1 for back, 1 for easy, 2 for medium
	Spritesheet tmp_txt;
}