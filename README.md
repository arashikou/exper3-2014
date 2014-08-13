# What is EXPER3?

EXPER3 is a contest. It is a birthday gift. And it is an opportunity.

In May of 2014, I turned 30. My amazing wife knew that my greatest regret upon closing out my 20s was that constantly prioritizing other things (often, though not always, more responsible things) had kept me from ever pursuing my dream of making video games, even as a hobby. So as a gift, she set forth for me a challenge. To take the month of July and do a month-long game jam, a sort of game-creating NaNoWriMo. She called it EXPER3, for "Experience, Experiment, & Expertise."

It was meant to force me to make the choice to prioritize my dream. It was meant to prove to me that I could do it. It was meant to show me that I could still lead my life at the same time as pursuing my passions. I couldn't have asked for a better gift. I mean, I couldn't have even conceived of _this_ gift, but in hindsight, it was absolutely the perfect gift for my 30th birthday.

And then we bought our first home and things got hectic and we realized there was no way I could be ready to start on July 1st. (Heck, I didn't have a computer or internet access at that point.) So the whole thing got delayed until July 12th.

But EXPER3 began on-time on the 12th, and all the checkins will be going right here. The goal is to make four games in a month while still living my normal life. Like NaNoWriMo, the results will not be "publication-ready," but they will be playable drafts that I might later refine into more complete games. And I've decided to open-source the EXPER3 drafts here. It's not just a way of sharing what I'm doing with the world, it's also a way of keeping me accountable and a way to let friends and family keep up-to-date with my work without requiring me to write long updates every day. (Thus eating into precious time.)

Of course, I also hope whatever is produced here could be of interest to other people, either as a fun game to play or as a reference to how to create a game with the tools I'm using.

# What is the Format of EXPER3?

Amy gave me the choice of either focusing on one big game for the whole month or four smaller games. I chose the latter because I know my eyes are often bigger than my abilities, and I could easily overcommit myself. I want to force myself to keep my focus small.

Like Ludum Dare, EXPER3 has a theme that the games must adhere to. That theme is **power**. How I interpret that is up to me. I'm trying to make sure I interpret it differently in each game as a creative challenge.

EXPER3 also has an unofficial second theme. That theme is **moose**. This isn't actually a rule Amy set, but the fake newspaper she wrote as part of my birthday present needed some space-filler, and the software she was using filled it in with a second story about the global moose market. It was very funny and left an impression on the people at my birthday party. It just seems appropriate to include moose in EXPER3 in some capacity.

# What Tools Are You Using?

I'm drawing the art in Paint.NET. I'm creating the sound effects in bfxr. I'm composing the music in Musagi.

For source code, I'm writing all four games in Haxe, using the HaxeFlixel engine on top of the OpenFL/Lime framework. This may sound like a thick stack, but it has a number of advantages for me:

1. Haxe is a modern language with powerful functional programming capabilities.
1. I used the AS3 version of Flixel to make one of the few other games I ever created, so I am familiar with its interface.
1. HaxeFlixel has a low boilerplate cost to starting up a new project, which is something I'll be doing four times.
1. HaxeFlixel has an API that elides just the right amount of work for what I want to do. It provides the essentials of windowing, audio, input, and sprite-based rendering, and then it gets out of the way. This means I can write four very different 2D games on the same framework.
1. HaxeFlixel isn't _over_-engineered for the kind of simple, 2D games I'm making, so I won't be fighting needless abstractions or be waylaid by working around features I don't even want to use.
1. I'm still a coder at heart, and that means I am most comfortable working with source code instead of a GUI. EXPER3 is not the time to try to change this.

This does pose some amount of risk. Although I've used many languages like Haxe, I've never written a large project in Haxe itself. I am betting on this not being a huge impediment, but we shall see.

# What Platforms Do These Games Run On?

Although Haxe/Lime/OpenFL/HaxeFlixel (HLOF?) has robust support for multiple platforms, for the sake of simplicity during the contest time crunch, I'll be focusing on the same platform I'm developing on: Windows PC. That said, the games should run without modification on Mac OS X and Linux. But I won't be doing any work to support any smartphones, tablets, or game consoles during EXPER3. That's an added complication I just don't need.

# How Can I Run the Games?

If you are not comfortable with compiling source code from the command line, I recommend you wait. I will release downloadable binaries of all the games after the contest is over.

If you are comfortable with compilation, you'll first need to install [Haxe](http://www.openfl.org/documentation/setup/install-haxe/), [Lime](http://www.openfl.org/documentation/setup/install-lime/), [OpenFL](http://www.openfl.org/documentation/setup/install-openfl/), and [HaxeFlixel](http://haxeflixel.com/documentation/install-haxeflixel/), in that order. These games are simple enough that they perform well even on the Neko VM, so there's no need to set up your platform-specific Lime toolchain. Once this is done, you can `cd` into any game's directory and execute `lime test neko` to run the game.

# So What Are the Games?

**_Jump Fight_ - Power as Enabler**

A platforming game focused on ascending a randomly-generated tower while gaining the power to overcome enemies by defeating weaker enemies.

**_The Plug Mazes_ - Power as Electricity**

A puzzle game about completing an electric circuit using the cables and constraints provided.

**_The Moose Drivers_ - Power as Resource**

A light simulation game about moose herding.

**_Madame Pinna Saves the World_ - Insight as Power**

A bullet hell about predicting the future.
