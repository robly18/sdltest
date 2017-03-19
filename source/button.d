import derelict.sdl2.sdl;

import spritesheet;
import constants;

class Button {
	this(const SDL_Rect r, Sprite hi, Sprite lo, void delegate() act = null) {
		rect = r;
		high = hi;
		low = lo;
		action = act;
	}
	
	void render(SDL_Surface* surface) {
		SDL_Point p;
		int cstate = SDL_GetMouseState(&p.x, &p.y);
		p.x /= SCALE; p.y /= SCALE;
		
		if (SDL_PointInRect(&p, &rect) && cstate & SDL_BUTTON_LEFT) {
			low.render(surface, rect);
		} else {
			high.render(surface, rect);
		}
	}
	
	void checkEvent(int x, int y, int b) {
		SDL_Point p = {x/SCALE, y/SCALE};
		if (SDL_PointInRect(&p, &rect) && b == SDL_BUTTON_LEFT) {
			if (action)
				action();
		}
	}
		
private:
	SDL_Rect rect;
	void delegate() action = null;
	
	Sprite high, low;
}