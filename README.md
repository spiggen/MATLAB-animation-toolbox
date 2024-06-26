# MATLAB animation toolbox
Author: Vilgot Lötberg
<h2>Functions</h2>

- animation()
- animate()
- save_animation()
- n_characters()

<h2>animation()</h2>

animation() returns an animation-object, which is a task scheduled
to be performed when it's fed into the animate-routine. The animation
contains a function which is the thing that is actually going to be performed
for each frame of the animation-sequence. You can then feed
input-arguments into this function, these input-arguments
will be fed in for each time they take on a value between from_cell to
to_cell. The syntax for this is the following:

```MATLAB:Code
my_fun = @(argument1, argument2) plot(argument1, argument2);

my_anim = animation(@(args)my_fun(args{1},   args{2}), ...        % the function to be performed during animation
                                  {0:0.1:10, sin(0:0.1:10)}, ...  % field-values corresponding to argument1 and argument2, initial values 
                                  {0:0.2:20, cos(0:0.2:20)});     % field-values corresponding to argument1 and argument2, end values

animate({my_anim})                                                % animation routine takes in a list of animations to be performed in parallel

```
The animation-routine is then going to interpolate between the initial
argument-values and the end argument-values to get a smooth animation
sequence.

![](methods/documentation.gif)

It is also possible to change to change which keyframes the animation is
active for.

```MATLAB:Code

my_anim = animation(@(args)my_fun(args{1},   args{2}), ... 
                                 {0:0.1:10, sin(0:0.1:10)}, ... 
                                 {0:0.2:20, cos(0:0.2:20)}, ...
                                  "KeyFrames", [50,200]);          % Keyframes at which the animation starts displaying and stops displaying. 

```
As well as the rate of change of the animation at the beginning and end
note though that this is not normalised against the length of the clip, 
but rather against the length of a frame. Thus, to make the clip end with 
the same velocity as it has in the middle of the clip, one would do the
following:
```MATLAB:Code
my_anim = animation(@(args)my_fun(args{1},   args{2}), ... 
                                 {0:0.1:10, sin(0:0.1:10)}, ... 
                                 {0:0.2:20, cos(0:0.2:20)}, ...
                                  "KeyFrames", [50,200], ...
                                  "KeyRates", [0, 1/(200-50)]  ); % rates of change at beginning and end of clip.
```
![](methods/documentation2.gif)

<h2>animate()</h2>
animate() is a routine takes in a list of animations to be rendered, and
renders them on top of each-other for each frame, allowing you to write 
an animation with ony 3 lines or less worth of code.
Example:

```MATLAB:Code
my_fun = @(argument1, argument2) plot(argument1, argument2);

my_anim = animation(@(args)my_fun(args{1},   args{2}), ...        % the function to be performed during animation
                                  {0:0.1:10, sin(0:0.1:10)}, ...  % field-values corresponding to argument1 and argument2, initial values 
                                  {0:0.2:20, cos(0:0.2:20)});     % field-values corresponding to argument1 and argument2, end values

animate({my_anim})                                                % animation routine takes in a list of animations to be performed in parallel
```

The animation-routine is then going to interpolate between the initial
argument-values and the end argument-values to get a smooth animation
sequence.

It is also possible to change the keyframes of the animate-routine by
feeding it a list of keyframes you want to render, for example:

```MATLAB:Code
animate({my_anim}, 0:100);        % Renders the animation for each time the keyframe-number is 0,1,2,3...,100.

animate({my_anim}, 0:2:100);      % Renders the animation for each time the keyframe-number is 0,2,4,6...,100. 
                                  % Will go twice as fast as the first one
animate({my_anim}, 0:0.2:100);    % Renders the animation for each time the keyframe-number is 0,0.2,...,100.  
                                  % Will go 1/5 as fast as the first one
animate({my_anim}, [0,50,3,0.2]); % Renders the animation for each time the keyframe-number is 0,50,3,0.2.  
                                  % The routine uses the keyframes to know where to evaluate the interpolation, 
                                  % so this animation will appear choppy, but you could if you wanted to for some reason.

```

![](methods/documentation.gif)
![](methods/documentation3.gif)
![](methods/documentation4.gif)

<h2>save_animation()</h2>


save_animation() is a utility to create an animation-object which, when put
into the animation-routine, saves the animation to a file.
Example:

```MATLAB:Code
my_axes = axes();

my_fun = @(argument1, argument2) plot(my_axes, argument1, argument2);

[saver, videoObj] = save_animation(my_axes, "sine2cosine_video.mp4")

my_anim = animation(@(args)my_fun(args{1},   args{2}), ...        % the function to be performed during animation
                                  {0:0.1:10, sin(0:0.1:10)}, ...  % field-values corresponding to argument1 and argument2, initial values 
                                  {0:0.2:20, cos(0:0.2:20)});     % field-values corresponding to argument1 and argument2, end values

animate({my_anim, saver})                                         % animation routine takes in a list of animations to be performed in parallel

close(videoObj)

```

<h2>n_characters()</h2>

n_characters() takes in a list of strings, where each string represents one
row of text, and a double n (that will be rounded to nearest integer).
The out_array will then contain the first n'th characters.



<h2>Examples:</h2>
(Only gifs as markdown wont show mp4's.)

![](methods/newtons_convergence.gif)
![](methods/cursed.gif)
![](methods/flower.gif)
![](methods/axel.gif)

