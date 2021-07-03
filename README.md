# Fidgeting Bits Talon Repo README

The main difference between this repo and knausj_talon is my fairly extensive
vim support. I also sometimes have custom functionality that I haven't had time
to create pull requests for, or that otherwise isn't sufficiently generic to be
able to provide to everyone to use.

This repo is meant to be used on Linux and is only tested on Arch.  It requires
some non-standard python libraries in the talon virtual environment.

This is also developed around beta version of Talon so may result in errors
related to functionality.

In general I try to keep things compatible with the knausj_talon repo, and also
try to contribute back generic parts when I have time. 


## Hardware

Microphone:
Primary: DPA d:fine 4188 and DPA d:vice interface. 
Secondary: I have a Sennheiser MD 431 II and Focusrite Scarlet Solo

I rarely use a keyboard but I have a gergoplex with 12g khalhi switches. As a
backup I have an ergo dox glow with 60g cherry brown mx switches.

I use a Tobii 4c eye tracker on my primary system. I use dual 27" monitors, with the right monitor having the eye tracker and webcam. 


I use a Tobii 5 on my more portable laptop.

Foot pedal: I use a stinky board.

## Setup

In order to run talon on Arch I had to install the follow
dependencies:

skia-sharp
qt5-base ?

## Software

I keep all of the code from knausj in my repo, but I only rely on a few things
on the regular. Software that I tend to heavily use for my day to day, and thus
is particularly well tested in this repo:

firefox
keepassxc
vim
termite
zsh


## Recommendations

Although not Talon specific, I recommend using howdy 

## Dependencies
notify-send.sh
In order to use dunst for notifications, this repo monkey patches talon notifications to call notify-send.sh instead of qt notifications
