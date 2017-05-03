# CarND-Controls-PID
Self-Driving Car Engineer Nanodegree Program

---

## Dependencies

* cmake >= 3.5
 * All OSes: [click here for installation instructions](https://cmake.org/install/)
* make >= 4.1
  * Linux: make is installed by default on most Linux distros
  * Mac: [install Xcode command line tools to get make](https://developer.apple.com/xcode/features/)
  * Windows: [Click here for installation instructions](http://gnuwin32.sourceforge.net/packages/make.htm)
* gcc/g++ >= 5.4
  * Linux: gcc / g++ is installed by default on most Linux distros
  * Mac: same deal as make - [install Xcode command line tools]((https://developer.apple.com/xcode/features/)
  * Windows: recommend using [MinGW](http://www.mingw.org/)
* [uWebSockets](https://github.com/uWebSockets/uWebSockets) == 0.13, but the master branch will probably work just fine
  * Follow the instructions in the [uWebSockets README](https://github.com/uWebSockets/uWebSockets/blob/master/README.md) to get setup for your platform. You can download the zip of the appropriate version from the [releases page](https://github.com/uWebSockets/uWebSockets/releases). Here's a link to the [v0.13 zip](https://github.com/uWebSockets/uWebSockets/archive/v0.13.0.zip).
  * If you run OSX and have homebrew installed you can just run the ./install-mac.sh script to install this
* Simulator. You can download these from the [project intro page](https://classroom.udacity.com/nanodegrees/nd013/parts/40f38239-66b6-46ec-ae68-03afd8a601c8/modules/aca605f8-8219-465d-9c5d-ca72c699561d/lessons/e8235395-22dd-4b87-88e0-d108c5e5bbf4/concepts/6a4d8d42-6a04-4aa6-b284-1697c0fd6562) in the classroom.

## Basic Build Instructions

1. Clone this repo.
2. Make a build directory: `mkdir build && cd build`
3. Compile: `cmake .. && make`
4. Run it: `./pid`.

## Building using Docker

1. docker build -t carnd .
2. docker run -p 127.0.0.1:4567:4567 carnd ./pid

## Video

A demo video of the car driving around the track can be found [here](https://youtu.be/V7Vk7yQCk6A).

## Reflection
### Importance and effects of components in PID algorithm

In both the steering controller and the throttle controller the parameters of the different components have similar values. The P and the D components seems to be the most important. 

The P component makes our car steer quickly towards the planned trajectory and makes sure that the reference speed is quickly attained. So, the higher the Kp parameter the faster the reaction to the cross track error. If the parameter is too high, though, then the controllers will oscillate, without stabilizing.

The task of the D component is to reduce or even eliminate the zig-zag motion of the car and to reduce the oscillation of the throttle. If the Kd parameter is too low then, the car will zig zag and the throttle will still oscillate. If, on the other hand, Kd is too high then it will take a long time for the car to reach the planned trajectory and it will take ages for the speed to be reached.

The I component seems to plays the least important role given the low value of its parameter Ki. Yet, the parameter should not be zero. The component's task is to eliminate any bias that might appear in the controllers.

Ideally for the throttle control there would be reference speeds given along the trajectory. Or, at least the possibility to see what part of the trajectory that lies ahead so that the reference speed (and hence the optimal throttle) can be calculated before the car enters different pieces of track like a straight part or a (sharp) turn.


### Tuning hyperparameters
The Kp, Ki and Kd values for both the steering and throttle PID controller were tuned manually. They were tuned manually one at a time starting with Kp, then Kd and then Ki. This order was chosen due to the relative importance of each of those values, with the most important being tuned first. The starting values were Kp = 0.1 and Kd = 0.0 and Ki = 0.0.

It seems that it would have been a good idea to plot the cross track errors for both controllers. Visualizing the effect of the components in a graph would probably have made it easier (quicker) to tune the parameters.