# What is EXPER3?

EXPER3 was a contest. It was a birthday gift. And it was an opportunity.

In May of 2014, I turned 30. My amazing wife knew that my greatest regret upon closing out my 20s was that constantly prioritizing other things (often, though not always, more responsible things) had kept me from ever pursuing my dream of making video games, even as a hobby. So as a gift, she set forth for me a challenge. To take the month of July and do a month-long game jam, a sort of game-creating NaNoWriMo. She called it EXPER3, for "Experience, Experiment, & Expertise." The goal was to make four games in a month while still living my normal life.

It was meant to force me to make the choice to prioritize my dream. It was meant to prove to me that I could do it. It was meant to show me that I could still lead my life at the same time as pursuing my passions. I couldn't have asked for a better gift. I mean, I couldn't have even conceived of _this_ gift, but in hindsight, it was absolutely the perfect gift for my 30th birthday.

And then we bought our first home and things got hectic and we realized there was no way I could be ready to start on July 1st. (Heck, I didn't have a computer or internet access at that point.) So the whole thing got delayed until July 12th. But then it totally happened!

Like NaNoWriMo, the results are not "publication-ready," but they are playable drafts that I could later refine into more complete games. I've decided to upload all my work to GitHub and open-source the four games. This is a way of sharing what I'm doing with the world, but during the contest, this was also a way to let friends and family keep up-to-date with my work. And it will provide me with a record of my efforts, a digital memory chest of this awesome contest.

# What was the Format of EXPER3?

Amy gave me the choice of either focusing on one big game for the whole month or four smaller games. I chose the latter because I knew my eyes were often bigger than my abilities, and I could easily overcommit myself. I wanted to force myself to keep my focus small.

Like Ludum Dare, EXPER3 had a theme that the games must adhere to. That theme was **power**. How I interpreted that was up to me. I tried to interpret it differently in each game as a creative challenge.

EXPER3 also had an unofficial second theme. That theme was **moose**. This wasn't actually a rule Amy set, but the fake newspaper she wrote as part of my birthday present needed some space-filler, and the software she was using filled it in with a second story about the global moose market. It was very funny and left an impression on the people at my birthday party. So it just seemed appropriate to include moose in EXPER3 in some capacity.

# What Tools Did You Use?

I drew the art for all four games in Paint.NET. I created the sound effects for _Jump Fight_ in bfxr. I composed the music for _Jump Fight_ in Musagi. The other games either lack sound effects and music or incorporate sound and music from other people.

For source code, I wrote all four games in Haxe, using the HaxeFlixel engine on top of the OpenFL/Lime framework. This may sound like a thick stack, but when I started, I perceived it as having a number of advantages for me:

1. Haxe is a modern language with powerful functional programming capabilities.
1. I used the AS3 version of Flixel to make one of the few other games I ever created, so I was familiar with its interface.
1. HaxeFlixel has a low boilerplate cost to starting up a new project, which is something I had to do four times.
1. HaxeFlixel has an API that elides just the right amount of work for what I wanted to do. It provides the essentials of windowing, audio, input, and sprite-based rendering, and then it gets out of the way. This means I could write four very different 2D games on the same framework.
1. HaxeFlixel isn't _over_-engineered for the kind of simple, 2D games I was making, so I wouldn't be fighting needless abstractions or be waylaid by working around features I didn't even want to use.
1. I was and am a coder at heart, and that means I was most comfortable working with source code instead of a GUI. EXPER3 was not the time to try something different.

The risk of using this technology was that I wasn't significantly familiar with Haxe or HaxeFlixel when I started. Learning those technologies could have eaten up time better spent on other things. Or, they could have turned out to be less well-suited to my projects than I thought. Of these, the latter definitely happened, but it didn't prevent me from completing the contest.

# What Platforms Do These Games Run On?

Although Haxe/Lime/OpenFL/HaxeFlixel (HLOF?) has robust support for multiple platforms, for the sake of simplicity during the contest time crunch, I focused on the same platform I was developing on: Windows PC. That said, the games' source code should compile and run without modification on Mac OS X and Linux. The games will not run on smartphones, tablets, or game consoles without modification.

# How Can I Run the Games?

The [v1.0.0 release](https://github.com/arashikou/exper3/releases/tag/v1.0.0) has a ZIP file attached that contains Windows executables for all four games. You can also [click here](https://github.com/arashikou/exper3/releases/download/v1.0.0/exper3.zip) to download that same file. Just unzip the file you downloaded, and you should see four directories, one for each game. There's no need to install them to your computer, just run the programs from there. And to "uninstall," just delete the directory that was created when unzipping.

If you are comfortable with (or prefer) source code compilation, you'll first need to install [Haxe](http://www.openfl.org/documentation/setup/install-haxe/), [Lime](http://www.openfl.org/documentation/setup/install-lime/), [OpenFL](http://www.openfl.org/documentation/setup/install-openfl/), and [HaxeFlixel](http://haxeflixel.com/documentation/install-haxeflixel/), in that order. These games are simple enough that they perform well even on the Neko VM, so there's no need to set up your platform-specific Lime toolchain. Once this is done, you can `cd` into any game's directory and execute `lime test neko` to run the game.

# So What Are the Games?

**_Jump Fight_ - Power as Enabler**

A platforming game focused on ascending a randomly-generated tower while gaining the power to overcome enemies by defeating weaker enemies.

**_The Plug Mazes_ - Power as Electricity**

A puzzle game about completing an electric circuit using the cables and constraints provided.

**_The Moose Drivers_ - Power as Resource**

A light simulation game about moose herding.

**_Madame Pinna Saves the World_ - Insight as Power**

A bullet hell about predicting the future.
