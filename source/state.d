import constants;
public import derelict.sdl2.sdl;

class State {
	State tick() {
		return this;
	}
	void render(SDL_Surface* surface) {
	}
	void handleEvent(ref const SDL_Event e) {
	}
}