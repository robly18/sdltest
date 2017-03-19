import derelict.sdl2.sdl;
import constants;

import state;
import game;

class Engine {
	
	this( const(char)* name = "UNDEFNAME") {
		window = SDL_CreateWindow(name, SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, SW*SCALE, SH*SCALE, SDL_WINDOW_SHOWN);
		windowSurface = SDL_GetWindowSurface(window);
		surface = SDL_CreateRGBSurface(0, SW, SH, 32, 0xFF0000, 0x00FF00, 0x0000FF, 0);
		state = new Game();
	}
	
	void tick() {
		state = state.tick();
	}
	
	void render() {
		SDL_FillRect(surface, null, 0x000000);
		state.render(surface);
		SDL_BlitScaled(surface, null, windowSurface, null);
		SDL_UpdateWindowSurface(window);
	}
	
	bool handleEvents() {
		SDL_Event e;
		while (SDL_PollEvent(&e)) {
			switch (e.type) {
				case SDL_QUIT:
					return false;
				default:
					state.handleEvent(e);
					break;
			}
		}
		return true;
	}
	
	~this() {
		SDL_DestroyWindow(window);
	}
	
private:

	SDL_Window* window = null;
	SDL_Surface* windowSurface = null;
	
	SDL_Surface* surface = null;
	
	State state = null;
}