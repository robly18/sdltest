import state;
import button;
import spritesheet;

class ReplayState : State {
	this(State prevs) {
		tmp_txt = new Spritesheet("texture.png");
	
		bback = new SpriteButton(SDL_Rect(36,30+34,32,32), tmp_txt.makeSprite(64,0,32,32), tmp_txt.makeSprite(64,32,32,32), tmp_txt.makeSprite(0, 64, 32, 32));
		breplay = new SpriteButton(SDL_Rect(36+32,30+34,32,32), tmp_txt.makeSprite(64,0,32,32), tmp_txt.makeSprite(64,32,32,32), tmp_txt.makeSprite(32, 64, 32, 32));
		bg = tmp_txt.makeSprite(64, 64, 64, 32);
		txt = tmp_txt.makeSprite(64+32, 64+32, 32, 32);
		
		previousState = prevs;
	}

	override State tick() {
		return this;
	}
	override void render(SDL_Surface* surface) {
		previousState.render(surface);
	
		bback.render(surface);
		breplay.render(surface);
		bg.render(surface, SDL_Rect(36, 30, 64, 32));
		txt.render(surface, SDL_Rect(36+32, 30, 32, 32));
	}
	override void handleEvent(ref const SDL_Event e) {
	}

public:
	Button bback, breplay;
	Sprite bg, txt;
	
	Spritesheet tmp_txt;
	
	State previousState;
	State nextState;
}