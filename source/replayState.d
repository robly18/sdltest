import state;
import button;
import spritesheet;

class ReplayState : State {
	this() {
		tmp_txt = new Spritesheet("texture.png");
	
		bback = new Button(SDL_Rect(0,0,64,32), tmp_txt.makeSprite(0,0,64,32), tmp_txt.makeSprite(0,32,64,32));
		breplay = new Button(SDL_Rect(64,0,64,32), tmp_txt.makeSprite(0,0,64,32), tmp_txt.makeSprite(0,32,64,32));
	}

	override State tick() {
		return this;
	}
	override void render(SDL_Surface* surface) {
		SDL_FillRect(surface, null, 0xFFFFFF);
		bback.render(surface);
		breplay.render(surface);
	}
	override void handleEvent(ref const SDL_Event e) {
	}

public:
	Button bback, breplay;
	Sprite sback, sreplay;
	
	Spritesheet tmp_txt;
}