# Code Samples

A collection of Lua and Python projects exploring AI, automation, games, and simulations.

## Blogger_Robot

Blogger_Robot is a social media tool built with Python – it uses the OpenAI API to generate blog posts and images. Topics and image prompts are configured in `subjects.yaml`.

For each topic, the tool creates a folder containing the article, images, and SEO metadata. Example outputs are available in the `blog_posts` folder.

The generated content can be published to a blogging platform through an API or adapted for business social media.

## Neural Network

A compact feed-forward neural network implemented from scratch in Lua, including the required matrix operations. Its architecture is configurable with any number of hidden layers and a custom learning rate. The implementation uses sigmoid activation, randomized weights, forward propagation for predictions, and backpropagation for training.

I have used the core implementation in the interactive [Curio Neural Network](https://curioarcade.com/curio-neural-network/) app.

## Robot

A lightweight web automation framework built with Python and Selenium. It provides reusable helpers for opening pages, clicking elements, filling in fields, selecting options, scrolling, and waiting for page elements.

The example in `robot_task.py` demonstrates these features by automating interactions on my own website, [Manifold Math](https://manifoldmath.com/).

## Snake

A classic Snake game built with Lua and the LÖVE game engine. Guide the snake around the grid with the arrow keys, collect food to grow and increase your score, and avoid colliding with the walls or the snake's own body. The game tracks both your score and number of steps, and automatically restarts after a collision.

## Cells

A cell simulation built with Lua and the LÖVE game engine. Cells consume food that appears on the screen, grow, and eventually divide. A cell disappears if it goes without food for too long. Press Space to create new cells and Esc to close the simulation.
