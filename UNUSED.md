# Things I don't use *emacs* for and why

I think you could easily use *emacs* for everything and that it *could* be the
best choice for everything. As an operating environment, it is just
superior. However, not all things have good enough solutions to warrant their
usage.

## Email

I don't currently use *emacs* for email. I currently use Thunderbird.

I used to use *gnus* in *emacs* for email. I stopped for a few reasons:

1. eww was not very good and all email is html nowadays. It was tiring to parse
   through html to read text. HTML preview has since been fixed in *emacs* and you
   can reasonably see formatted emails.
2. Contact management and syncing was and still is awful. *bbdb* is not really
   performant and seems unneeded. Getting data into it was a hassle. org-mode
   has a contact mode that I like. It is more intuitive. Getting contact info
   into and out of it is a no go as of yet. The only solution that seems to work
   is *vdirel* and that requires python. It is tied to helm and kinda feels
   hacky because of that. I am not willing to run helm just to get this
   functionality. There is nothing as clean as *org-caldav-sync* but for vcard,
   which is want I want. Further, by default most *emacs* mail clients try to
   save all from addresses in received email into your contacts. This is
   annoying since 90% of email is spam. Why would I care about who these people
   are or want to pollute my contact list with this corporate garbage?
3. I don't like email to begin with, and so I only use it to get notices to pay
   bills and see what packages are being sent to my door when. The rest is
   spam. This means I don't use it enough to remember chords. For something I
   rarely use, it is sometimes better just to have a dumb GUI that is
   automatically configured and has big clicky buttons. Programs like
   Thunderbird have configuration screens that are very well documented and
   *emacs* solutions just are not. I don't want to spend the time to set up
   *emacs* for *email* just to get a less usable experience than what Thunderbird
   provides turnkey. That is apparently still the state *emacs* is in.

It is a pity because nothing I have used since *gnus* was better than the *gnus*
rule and folder management. However, I just don't need it now. Now-a-days, 90%
of email goes to spam-- the rest is easy enough to manually drag and drop into
the folder it goes to, as a worst case scenario.

## Music playback

Ideally, I just wanted something turn click. I used *emms* very early on. I
eventually moved to Rhythmbox when I stopped using RatPoison and went back to
GNOME2, and later Mate. I didn't run *emacs* on my home machine all the time and
it felt funny starting it just to play an ogg file and having to get really
close to see what was next. With other solutions, the icon was viewable across
the room. So using *emms* kinda felt tedious. This is another area where nice
GUI pictures and point-click would be better for 90% of my use-cases.

Rhythmbox, it was "ok". It was better than anything else I had seen others use
 commercially except for Pandora. It blended in with GNOME and Mate. I never
 really thought it looked good, however. The functionality never wowed me.

A couple years ago I abandoned Mate as they kept shoving more bloatware from
GNOME 3 into the base GTK layer where it didn't belong. This made Mate kinda
bloated and less secure. It was also getting buggier all around.

I currently use LXQT or exwm for a desktop environment and I avoid most gtk3
programs. I started looking for a QT based media player to go along with LxQt.

I now use Clementine for music and find it to be a very powerful combination of
media playback and metadata editing. It looks and works slick. I don't really
miss *emms* and I certainly don't miss the myriad spyware accessibility and conf
daemons required to use it. Clementine really feels like the authors put some
love into the small details. For example, how the sound fades out when you
switch playlists. Or how you can edit metadata fields across multiple files at
the same time, seamlessly from the GUI while the songs are playing. That kinda
stuff is nice. The GUI background is also polished and themed, yet totally
readable and crisp. It is not embarrassingly ugly to look at like Rhythmbox or
un-ergonomic like most many of the multimedia apps that look like a 80's
aftermarket car stereo boomboxes complete with 1000 tiny unreadable buttons.

# Broken stuff and problems I have not found a solution for yet

There is some stuff I am not really happy with...

# exwm

This *exwm* is addicting. I used to use ratpoison and only abandoned it because
some programs would not behave with it back in the day. It was tedious to use it
with things that didn't lend themselves to tiling and just assumed everything
was a floating window. While the rat would allow you to switch window managers
temporarily, I found it never totally worked.

Further, some applications would just crash it randomly no matter what. So I
gave up. I have always missed it. I tried to use StumpWM, but I am not a lisp
programmer and found I didn't have the time to devote to learning Stump or lisp
enough to configure it to work as well as the rat worked for me. I then tried
ion and some others. No other tiling window manager felt as configurable,
controllable and minimalistic as rat poison. All of them seemed to be buggy with
some apps that I needed.

I started using *exwm* recently, and it just kinda hit the spot. However, it
locks up more and more, but only with certain programs. Krita and OpenOffice are
no-goes. Firefox/Icecat and Chromium are just fine. Lots of pop-up menus seem to
really upset it. *Clementine* seems to behave itself though. 

It is not maintained anymore, so this is going to be a problem as I dont' want
to quit using it. It kinda feels like rat-poison all over again.

Linux desktops seem to be like Western Governments lately: They get worse and
worse each iteration. *exwm* was an exception and I don't like to see it stalled
out this way.

# emacs antiquated look and toolkit support

*emacs* supports a limited number of toolkits. The only one worth using is the
gtk3 toolkit. The rest are archaic and look like poo. I wish *emacs* had an
option to build with QT toolkit bindings. I am sure there are probably still
issues with QT licensing as there have always been. It doesn't help that whoever
owns it changes the qt license constantly.

I don't like having to build with gtk3, since it has gone down its path of
sadness. Honestly, if this were any other program, I would likely have stopped
using it due to the gtk3 requirement. I would have at least looked at
alternatives. Since it is *emacs* there are really no other alternatives.

# emacs single threaded main loop

To a lesser extent, the single-threaded thing is annoying. Between *async* and
*gccjit* native compilation-- performance seldom bothers me. It would be nice to
have time-slices that keep the stuff running in modes from being able to lock
the main processing and display loop (this happens pretty much only with exwm at
this point, and occasionally with lsp-mode). Bottom line is that nothing
happening in a mode or mode hook should ever keep me from typing input into
the buffer.

While the stutters don't happen often, I know any package that I install *could*
muck up the works due to the design. It would be nice if it just wasn't
possible. Since just about all other editors are also single threaded, this
isn't the end of the world since I don't get anything better here by switching
to them. However, it still costs me productivity.

