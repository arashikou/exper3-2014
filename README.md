# What is EXPER3?

EXPER3 is a contest. It is a birthday gift. And it is an opportunity.

In May of 2014, I turned 30. My amazing wife knew that my greatest regret upon closing out my 20s was that constantly prioritizing other things (often, though not always, more responsible things) had kept me from ever pursuing my dream of making video games, even as a hobby. So as a gift, she set forth for me a challenge. To take the month of July and do a month-long game jam, a sort of game-creating NaNoWriMo. She called it EXPER3, for "Experience, Experiment, & Expertise."

It was meant to force me to make the choice to prioritize my dream. It was meant to prove to me that I could do it. It was meant to show me that I could still lead my life at the same time as pursuing my passions. I couldn't have asked for a better gift. I mean, I couldn't have even conceived of _this_ gift, but in hindsight, it was absolutely the perfect gift for my 30th birthday.

And then we bought our first home and things got hectic and we realized there was no way I could be ready to start on July 1st. (Heck, I didn't have a computer or internet access at that point.) So the whole thing got delayed until July 12th.

But come the 12th, the starting pistol will fire and EXPER3 will begin, and all the checkins will go right here. The goal is to make four games in a month while still living my normal life. Like NaNoWriMo, the results will not be "publication-ready," but they will be playable drafts that I might later refine into more complete games. And I've decided to open-source the EXPER3 drafts here. It's not just a way of sharing what I'm doing with the world, it's also a way of keeping me accountable and a way to let friends and family keep up-to-date with my work without requiring me to write long updates every day. (Thus eating into precious time.)

Of course, I also hope whatever is produced here could be of interest to other people, either as a fun game to play or as a reference to how to create a game with the tools I'm using.

# What Tools Are You Using?

I'm going to write all four games in Haxe, using the HaxeFlixel engine on top of the OpenFL/Lime framework. This may sound like a thick stack, but it has a number of advantages for me:

1. Haxe is a modern language with powerful functional programming capabilities.
1. I used the AS3 version of Flixel to make one of the few other games I ever created, so I am familiar with its interface.
1. HaxeFlixel has a low boilerplate cost to starting up a new project, which is something I'll be doing four times.
1. HaxeFlixel has an API that elides just the right amount of work for what I want to do. It provides the essentials of windowing, audio, input, and sprite-based rendering, and then it gets out of the way. This means I can write four very different 2D games on the same framework.
1. HaxeFlixel isn't _over_engineered for the kind of simple, 2D games I'm making, so I won't be fighting needless abstractions or be waylaid by working around features I don't even want to use.
1. I'm still a coder at heart, and that means I like working with source code instead of a GUI. EXPER3 is not the time to try to change this.

This does pose some amount of risk. Although I've used many languages like Haxe, I've never written a large project in Haxe itself.

# What Platforms Do These Games Run On?

Although Haxe/Lime/OpenFL/HaxeFlixel (HLOF?) has robust support for multiple platforms, for the sake of simplicity during the contest time crunch, I'll be focusing on the same platform I'm developing on: Windows PC. That said, the games should run without modification on Mac OS X and Linux. But I won't be doing any work to support any smartphones, tablets, or game consoles during EXPER3. That's an added complication I just don't need.

# So What Are the Games?

You'll have to wait until EXPER3 starts to find out.
