import derelict.sdl2.sdl;
import derelict.sdl2.image;

class Spritesheet {
	this(const(char)* dir, Uint32 k = 0xFF00FF) {
		texture = IMG_Load(dir);
		SDL_SetColorKey(texture, SDL_TRUE, k);
	}
	
	~this() {
		SDL_FreeSurface(texture);
	}
	
	Sprite makeSprite(SDL_Rect r) {
		return Sprite(this, r);
	}
	Sprite makeSprite(int x, int y, int w, int h) {
		SDL_Rect r = {x,y,w,h};
		return Sprite(this, r);
	}
	
	SDL_Surface* texture;
}

struct Sprite {
	this(Spritesheet ss, SDL_Rect r) {
		spritesheet = ss;
		rect = r;
	}
	
	void render(SDL_Surface* s, SDL_Rect target) {
		SDL_BlitSurface(spritesheet.texture, &rect, s, &target);
	}
	
	Spritesheet spritesheet;
	SDL_Rect rect;
}