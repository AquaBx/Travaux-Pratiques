#include <iostream>
#include <SDL2/SDL.h>
#include <SDL2/SDL2_gfxPrimitives.h>
#include <Environment.h>
#include <Renderer.h>
#include <time.h>
#include <Timer.h>
#include <Agent.h>
#include <Food.h>
#include <Anthill.h>
#include <AnthillRespawn.h>

static unsigned int windowWidth() { return 1024; }
static unsigned int windowHeight() { return 700; }

/// <summary>
/// called each time a key is pressed.
/// </summary>
/// <param name="key">The key.</param>
/// <param name="environment">The environment.</param>
void onKeyPressed(char key, Environment* environment)
{
	if (key == 'a')
	{
		Vector2<float> v = environment->randomPosition();
		auto newfour = new AnthillRespawn(environment, v[0], v[1]);

		/* création des fourmis fait dans le constructeur de AnthillRespawn */

		//for (int i = 0; i < 100; i++)
		//{
		//	new Ant(environment, newfour);
		//}
	}

	if (key == 'f')
	{
		float q = MathUtils::random(200, 2000);
		Vector2<float> v = environment->randomPosition();
		new Food(environment, v[0], v[1], q);
	}
	if (key == 'd')
	{
		auto instances = environment->getAllInstancesOf<Food>();
		if (instances.size() > 0)
		{
			environment->getAllInstancesOf<Food>().at(0)->setStatus(Agent::Status::destroy);
		}
	}

	// std::cout << "Key pressed: " << key << std::endl;
}

/// <summary>
/// Called at each time step.
/// </summary>
void onSimulate()
{
	Agent::simulate();
}

/// <summary>
/// The main program.
/// </summary>
/// <param name="argc">The number of arguments.</param>
/// <param name="argv">The arguments.</param>
/// <returns></returns>
int main(int /*argc*/, char** /*argv*/)
{
	// 1 - Initialization of SDL
	if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_EVENTS/* | SDL_INIT_AUDIO*/) != 0)
	{
		SDL_Log("Unable to initialize SDL: %s", SDL_GetError());
		return 1;
	}
	// 2 - Initialization of the renderer
	Renderer::initialize(windowWidth(), windowHeight());

	// 3 - Creation of an environment
	Environment environment(windowWidth(), windowHeight());

	// 4 - We change the seed of the random number generator
	srand(static_cast<unsigned int>(time(nullptr)));

	// The main event loop...
	SDL_Event event;
	bool exit = false;
	while (!exit)
	{
		// 1 - We handle events 
		while (SDL_PollEvent(&event))
		{
			if ((event.type == SDL_QUIT) || (event.type == SDL_KEYDOWN && event.key.keysym.sym == 'q'))
			{
				std::cout << "Exit signal detected" << std::endl;
				exit = true;
				break;
			}
			if (event.type == SDL_KEYDOWN)
			{
				onKeyPressed(static_cast<char>(event.key.keysym.sym), &environment);
			}
		}
		// 2 - We update the simulation
		Timer::update(0.5);
		onSimulate();
		// 3 - We render the scene
		Renderer::getInstance()->flush();
	}

	std::cout << "Tuage des agents" << std::endl;
	Agent::finalize();

	std::cout << "Shutting down renderer..." << std::endl;
	Renderer::finalize();

	std::cout << "Shutting down SDL" << std::endl;
	SDL_Quit();

	return 0;
}
