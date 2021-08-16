# Mandala


Inspired by mathematician A. Chinchón, creating generative mandala art in R using Voronoi tesselation.

Brief explanation:

- Start obtaining n equidistant points in a unit circle centered in (0,0) 
- Repeat the process with all the points, obtaining new n points around each of them
- Discard the previous n points
- Repeat 1-3 iteratively a times, to obtain nª points
- Calculate Voronoi tesselation
- Graph using ggplot and colour using your own custom palettes

Complete explanation of the process can be found on my [website.](https://alishabhimani.ca/mandala/)

Here are few examples of what you can do:

<img src="https://github.com/alishabhimani/mandala/blob/main/img/mandala2.png" width="200" height="200"><img src="https://github.com/alishabhimani/mandala/blob/main/img/mandala5.png" width="200" height="200"><img src="https://github.com/alishabhimani/mandala/blob/main/img/mandala7.png" width="200" height="200">

