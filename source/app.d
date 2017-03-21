import derelict.sdl2.sdl;
import derelict.sdl2.image;
import engine;

void main() {
	DerelictSDL2.load();
	DerelictSDL2Image.load();
	SDL_Init(SDL_INIT_VIDEO);
	IMG_Init(IMG_INIT_PNG);
	
	auto engine = new Engine("Test");
	bool quit = false;
	while (engine.handleEvents() && engine.tick()) {
		engine.render();
	}
	
	SDL_Quit();
}
