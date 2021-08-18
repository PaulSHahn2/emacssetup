# Setting up the Kenesis Advantage II keyboard for emacs

This sections contains configuration notes specific to the Advantage II keyboard.

Note that the Keyboard manual is found here:

<https://kinesis-ergo.com/wp-content/uploads/Adv2-Users-Manual-fw1.0.517-4-24-20.pdf>

A good resource for programming this type of keyboard is found at xahlee.info:

<http://xahlee.info/kbd/kinesis_keyboard_howto.html>

## What does *keypad layer* mean?

Well, a layer you have used on any keyboard is the *shift* layer. The shift key
temporarily enters this layer while held down. We call the *shift* key a
*modifier key*.  The *capslock* key toggles turning it off and on-- without
having to keep holding down the shift key. We call that a *sticky* key-- it
stays on until pressed again to shut it off. Obviously, the shift layer makes
the keys print capitals instead of lower case and symbols instead of
numbers. Similarly, the number lock key locks the 10 key to emit numbers,
instead of being directional arrow keys.

In the case of the Advantage II keypad layer, the *keypd* button at the top
right triggers a separate layer as a sticky key. It is used out of the box to
let you ten key on this smaller keyboard. Like many laptop keyboards, this
keyboard doesn't have a physically separate keypad placed over to the right for
10 key use.  The keypad layer turns the keys normally used for entering letters
on the right side of the keyboard into a 10 key layer. So key *u* on a qwerty
version of the Advantage II keyboard becomes *7*, and so forth. Out-of-the box,
the left side of the keyboard remains bound to lowercase letters while the right
side is now a 10-key.

## Modifier key history

In the example above, the *Shift* key was said to be a modifier key. Pressing it
changed the functionality by changing the keyboard layer.

The word *layer* came about from the original mechanical type-writers. When you
pushed the *shift* key it acted as a lever-- physically shifting the
typewriter's internal mechanism upward and causing a different portion of the
striker to hit the paper, printing a capital instead of lower case. The first
mechanical caps-lock keys were ratcheting mechanisms that caught and held the
layer upward until released by pushing them twice. As typewriters became
electronic and later computer keyboards, the original nomenclature stuck and
continued to be used.

The first computers used keyboards with more modifier keys than we currently
have. These modifier keys were often larger and easier to reach. They were much
more ergonomic to use than the the modern "Control" key which requires the use
of your pinky finger-- a horrible finger from an ergonomic standpoint as it is
the smallest and most fragile. To contrast this, older computer keyboards had
modifier keys that were used by pressing the entire side of the users' hand
against the modifier key to hold it down. This is less stressful and doesn't
cause the same type of *RSI* damage.

*emacs* in particular was developed on an older system that had a keyboard known
as the *space cadet* keyboard. It was called this because it had so many
modifier keys that it looked like some type of control panel that would be used
at NASA. This is related because it explains why *emacs* evolved to have so many
key-bindings, which were ok for the user back then-- but not for the user with
most modern keyboards.

## What is a macro?

A macro is a stored series of key presses that can be replayed later on.

## What does binding a macro mean?

Binding means associating a stored macro or function to a short-cut key
combination which triggers its execution. Normally, typing *c* makes the letter
"c" appear on the screen of our editor. If we bound a macro to "c", it would
instead become a shortcut that typed whatever the macro told it to type instead
of printing the letter *c*. For example, if the programmed macro told it to type
"Hello", it would output *Hello* instead of *c*. That wouldn't be very usable,
since we need to type 'c' on occasion.

Usually macros and lisp functions are bound to a series of keys starting with a
modifier key. These combinations are called *chords*. For example, *C-x,
C-s* is a chord that saves the contents of an *emacs* buffer to disk. In this
case, an *emacs* function called *save-buffer* is bound to the chorded key
combination: *C-x, C-s*. You could rebind the *save-buffer* function to
any key or combination in *emacs* if you really wanted to. For example, *evil*
is an *emacs* package to make emacs more useable for users of the *vi/vim*
editor. Among other things, it provides alternate keybindings that mimic
*vi/vim*. *vi* users will know that the chorded combination that runs
*save-buffer* in *evil* mode is *:-w*.

## How do macros in emacs work?

*emacs* means *editor macros*. *emacs* is an editor that supports saving macros
and lisp functions into files. When the editor is started it re-reads the macro
and function files. It also reads configuration files. It then binds the
functions and macros to key chords according to configuration defined in the
configuration files. For the most important tasks, there are default keybindings
provided if none are found in the configuration files.

Saving, reloading and then replaying the macros and functions with bound chords
was a core concept of the editor. It was considered a "killer-feature" of its
day. This differentiated *emacs* from most other editors, where a keys meaning
were hard-coded and could not be re-configured. *emacs* could not only be
reconfigured, it could stay running while new functions and macros were bound
and re-bound as desired-- "on-the-fly".

## How do Kenesis keyboard macros work?

In the case of the Kenesis keyboard, when we talk about macros we are not
talking about *emacs* macros. Instead, we are talking about a feature of the
keyboard that allows you to save macros into the keyboard's memory and then
retrieve them and replay them without retyping them. Kenesis added this feature
as an ergonomic way to save keyboard users from having to type difficult
sequences over and over again. So when we talk about these macros, we are not
talking about storing macros inside of *emacs* itself, but inside the keyboard's
memory.

A keyboard stored macro will simply replay to the operating system, and the
macros stored could be intended for anything: such as a word processor, or a
button-combo for a video game. I just happen to save macros in my keyboard that
type out *emacs* *chords*. In case you are wondering: Yes, I could program
keyboard macros that in turn called custom written emacs macros. Which is very
meta.

So why create macros in the keyboard instead of just using *emacs* macros and
chords directly?

Because *emacs* only has so many high quality chord combinations to bind its own
macros and functions too. A downside of keyboards having few usable modifier
keys is that you eventually have macros and functions bound to weird
un-ergonomic keyboard combinations that aren't really usable:
*C-M-Spc-some-weird-thing-you-have-to-type-and-wont-remember-ever* is one of the
biggest criticism of *emacs*. For that matter, similar issues exist with any
program that reaches a high level of complexity, see *Blender* for example.

The traditional *IDE* way to handle this is to have large accordion drop-down
lists and iconified buttons everywhere-- cluttering up your screen with
cascading menus. This required you to cycle through the menus with a mouse, or
to also use hot keys and lots of arrow keys.

More modern approaches use a search to just find the command you want to run as
you type something resembling it into the search window, which is much
better. *emacs* has supported such *completions* via *i-search since its
inception.

The quickest option would be to have more usable keys to bind to so we can have
simpler to use and easier to remember key combinations, like the first *emacs*
users had.

## Rebinding/re-programming keys on the keyboard

We can expand the amount of modifier keys our keyboard has available. We can
reprogram the keypad layer to bind our macros to the keypad layer's keys. We
will probably want to stick to the left side of the keypad layer, since the
right side keys are intended for use as 10-key numerals. The left side keys are
bound in the keypad layer to the same bindings as they are outside the keypad
letter, so pressing "a" by default prints a letter "a". These keys are not
really useful as they are already in the standard layer, and thus we don't need
to have them available twice. So we can re-bind them. If we don't care about
10-keying, we can rebind the entire layer if we wish.

I rebind the keypad layer's left side keys to run complex chorded *emacs*
commands that I don't like remembering or typing over-and-over.

If we rebound the keypad layers *a* key to shoot lasers out of a robots eyes, by
calling *emacs* function *fire-robot-eye-lasers*-- then we could do something
like the following:

1. Press the *keypd* key to lock the keypad layer on, with right hand pinky or index.
2. Press the *a* key with left hand pinky.
3. Press the *keypd* key again to exit the keypad layer, as before.
4. Continue typing normal letter *a*'s since we are no longer in the keypad layer.

So far, this is not an improvement over using poorly chorded *emacs* keybindings
and commands, like say: *M-X fire-robot-eye-lasers*. What is worse is that the
*keypd* key is way up to the top right of the keyboard and is a second-class
tiny foamy-chicklet-style button that you cannot find by touch. It is not even a
real modifier key, but a sticky-key which toggles-- like *caps lock*. So we have
to push it twice and the *a* key once each time we want to fire robot lasers. So,
why bother with binding macros to this keypad layer when it is so awkward to get
to?

Two reasons: First, you can re-bind an existing key to perform the same action
as a non-sticky modifer key. Second, can press a foot pedal to access the keypad
layer as a non-sticky modifier key.

Xhlee rebinds his end key to toggle the keypad layer directly as a modifier:

```
[end]>[kpshift]
```

Now his end key can be used to access the keypad layer by holding it down while
pressing other keys. He must forgo the use of the *end* key for its more
traditional purpose.

His approach means we can now do the following:

1. Press and hold *end* key with left hand thumb.
2. Press *a* with pinky of left hand at same time.
3. Release *end* key with left hand thumb..
4. Continue typing normal a's as desired.

This is much faster, but still slightly awkward. Plus, if we want to go to the
end of a line in something besides *emacs*, we have to use the mouse or
something else-- our key for going to the end of the line is gone.

Kenesis also offers a series of foot pedal controllers. You can use one of these
as a big giant modifier key to toggle turning the keypad layer on and off, which
is the default action of the foot pedal out of the box.  So, pressing the pedal
with my foot activates the keypad layer for as long as I hold my foot down. This
is like the shift key engaging the shift layer only while it is held down.

With this approach, firing lasers is:

1. Press and hold foot pedal with either foot.
2. Press and release *a* key with left hand.
3. Release footpedal.

This is fastest and least awkward for me. It is not only faster than typing the
whole thing out, it is also faster than reaching for the rat and clicking on a
tiny icon in some far corner of a GUI IDE.

The advantage of using the keypad layer is that we have the macros available
wherever the keypad is available, even when we don't have foot-pedals. When the
keyboard is missing, such as with a laptop-- we still have the original *emacs*
keybindings to fall back to. We have not reprogrammed them or changed them and
our *emacs* setting is the same. So our functionality degrades gently and we are
not left with no way to get things done. Further, we have lost no additional
functionality. We can still 10-key if we left the left side keys alone.

The first disadvantage is that we cannot use the right side of the keypad layer for
new macros, since it is already in use for 10 key. Well, we can-- but we will
loose the use of it for 10-key purposes. Thus, we have a limited number of keys
we can bind to.

Another disadvantage is when we don't have a foot-pedal to trigger the keypad
layer, we must hit the *keypd* key to turn on the layer, then enter the key
sequence, then turn off the *keypd* layer. The other option is to rebind another
existing key to be the modifier that enters the keypad layer-- thereby loosing
the original key's functionality. This last approach sort-of puts us back to
where we started-- without the foot pedal we don't have enough modifier
keys. Now we are just remapping a modifier key to use it for another purpose,
thus loosing some functionality to gain some other functionality.

This is a price we have to pay without better hardware.

## Current Keypad layer to emacs command mapping

Some definitions are in order for non-native *emacs* users:

* **defun:** lisp-speak. Here, its use can be thought of as a programming function in most modes. *beginning-of-defun* would move to the start of the current function/method.
* **sexp:** Short for an S-expression in lisp-speak. Here, its use can be thought of as moving through a container, such as a list or dictionary. *forward-sexp* would move forward to the next item in the list, or the next key in a dictionary, or the next argument passed to a function, etc.

Below are the current keyboard macros I have programmed into my keyboard and what they do:

| keyboard keybinding | command | emacs keybinding (if bound) |
| -------------  |-------------| -----|
| **Cursor movement keys** |   |  |
| *foot-pedal - a* | beginning-of-defun      | C-M-a |
| *foot-pedal - e* | end-of-defun            | C-M-e |
| *foot-pedal - f*  | forward-sexp     | C-M-f |
| *foot-pedal - b*  | backward-sexp    | C-M-b |
| *foot-pedal - h*  |  mark-defun  | C-M-h |
| *foot-pedal - Space* | mark-sexp     | C-M-<SPC> |
| **General editing** | | |
| *foot-pedal - s* |  ispell-word | (Meta-$) |
| **Major and minor Mode toggles** | | |
| *foot-pedal - NumRow1* | fundamental-mode |  |
| *foot-pedal - NumRow2* | sh-mode |  |
| *foot-pedal - NumRow3* | yaml-mode |  |
| *foot-pedal - NumRow4* | json-mode |  |
| *foot-pedal - NumRow5* | python-mode |  |
| *foot-pedal - NumRow6* | flyspell-mode |  |
| *foot-pedal - NumRow7* | flyspell-prog-mode |  |
| **dired-sidebar** |    |    |
| *foot-pedal - q* | dired-sidebar-toggle-sidebar |  |
| **Projectile commands** | | |
| *foot-pedal - LCtrl - g* | grep in projectile project   | C-c p s g |
| *foot-pedal - LCtrl - c* | projectile-compile-project |  C-c p c |
| *foot-pedal - LCtrl - t* | projectile-compile-test      |  C-c p P |
| *foot-pedal - LCtrl - p* | projectile-package-project   | C-c p K  |
| *foot-pedal - LCtrl - i* | projectile-install-project   | C-c p L  |
| *foot-pedal - LCtrl - r* | Simple refactoring with text replace in current project | C-c p r |
| *foot-pedal - LCtrl - f* | Jump to any file in the project | C-c p f |
| *foot-pedal - LCtrl - d* | Jump to any directory in the project | C-c p d |
| *foot-pedal - LCtrl - b* | List buffers local to current project | C-c p b |
| *foot-pedal - LCtrl - e* | Jump to recently visited files in project | C-c p e |
| *foot-pedal - LCtrl - o* | Multi-occur in project buffers | C-c p o |
| *foot-pedal - LCtrl - s* | Switch visited projects (visited once and Projectile remembers) | C-c p p |
| *foot-pedal - LCtrl - a* | Switch between header and detail files .h and .c or .cpp | C-c p a |
| **lsp commands** |  |  |
| *foot-pedal - LAlt - y* | lsp-workspace-restart  | S-l w r |
| *foot-pedal - LAlt - z* | lsp-workspace-shutdown  | S-l w q  |
| *foot-pedal - LAlt - r* | lsp-rename |  S-l r r |
| *foot-pedal - LAlt - f* | lsp-format-region  |  |
| *foot-pedal - LAlt - b* | lsp-format-buffer |  S-l = = |
| *foot-pedal - LAlt - d* | lsp-find-definition |  S-l g g |
| *foot-pedal - LAlt - t* | lsp-find-type-definition | S-l g t |
| *foot-pedal - LAlt - left arrow* | lsp-find-references | S-l g r |
| *foot-pedal - LAlt - right arrow* | lsp-find-declaration | S-l g d |
| *foot-pedal - LAlt - down arrow* | lsp-treemacs-call-hierarchy | S-l g h |
| *foot-pedal - LAlt - up arrow* | lsp-find-implementation | S-l g i |
| *foot-pedal - LAlt - Space* | lsp-signature-activate | C-S-SPC |
| *foot-pedal - LAlt - h* | lsp-describe-thing-at-point | S-l h h |
| *foot-pedal - LAlt - s* | lsp-treemacs-symbols-goto-symbol |  |

## Sample keybinding layouts

Below are the commands that are saved to a layout text file on the keyboard to
program the above macros (read the keyboard owner's manual to see how to do this
as it can differ between models of Advantage keyboards).

**Note:** I don't use Super short-cuts but call the bound *emacs* function via
*M-x*. This is because I often run in a virtual machine, and in such cases the
super modifier is handled by Windows and doesn't get passed to the underlying
VM client. Calling the functions themselves works everywhere.

### Manually Rebind windows super to alt

I used to explicitly disable the super key since I liked having two alts for
two thumbed use on *Cntrl+Alt* key combos:

```
[rwin]>[ralt]
[kp-rwin]>[kp-ralt]
```

I no longer do this as I found that I try to avoid complex chords that require
*Cntrl+Alt* anyway, and I can usually press both at the same time with the left
thumb, if I think to do so.

### Current default qwerty layout


```
{kp-a}>{-lctrl}{-lalt}{a}{+lalt}{+lctrl}
{kp-e}>{-lctrl}{-lalt}{e}{+lctrl}{+lalt}
{kp-f}>{-kp-lctrl}{-kp-lalt}{kp-f}{+kp-lalt}{+kp-lctrl}
{kp-b}>{-kp-lctrl}{-kp-lalt}{kp-b}{+kp-lalt}{+kp-lctrl}
{kp-h}>{-lctrl}{-lalt}{h}{+lalt}{+lctrl}
{kp0}>{-lctrl}{-lalt}{space}{+lalt}{+lctrl}
{kp-s}>{-lalt}{-lshift}{4}{+lshift}{+lalt}
{kp-1}>{-lalt}{x}{+lalt}{d125}{f}{u}{n}{d}{a}{m}{e}{n}{t}{a}{l}{hyphen}{m}{o}{d}{e}{enter}
{kp-2}>{-lalt}{x}{+lalt}{d125}{s}{h}{hyphen}{m}{o}{d}{e}{enter}
{kp-3}>{-lalt}{x}{+lalt}{d125}{y}{a}{m}{l}{hyphen}{m}{o}{d}{e}{enter}
{kp-4}>{-lalt}{x}{+lalt}{d125}{j}{s}{o}{n}{hyphen}{m}{o}{d}{e}{enter}
{kp-5}>{-lalt}{x}{+lalt}{d125}{p}{y}{t}{h}{o}{n}{hyphen}{m}{o}{d}{e}{enter}
{kp-6}>{-lalt}{x}{+lalt}{d125}{f}{l}{y}{s}{p}{e}{l}{l}{hyphen}{m}{o}{d}{e}{enter}
{numlk}>{-lalt}{x}{+lalt}{d125}{f}{l}{y}{s}{p}{e}{l}{l}{hyphen}{p}{r}{o}{g}{hyphen}{m}{o}{d}{e}{enter}
{kp-q}>{-lalt}{x}{+lalt}{d125}{d}{i}{r}{e}{d}{hyphen}{s}{i}{d}{e}{b}{a}{r}{hyphen}{t}{o}{g}{g}{l}{e}{hyphen}{s}{i}{d}{e}{b}{a}{r}{enter}
{kp-lctrl}{kp-g}>{-lctrl}{c}{+lctrl}{p}{s}{g}
{kp-lctrl}{kp-c}>{-lctrl}{c}{+lctrl}{p}{c}
{kp-lctrl}{kp-t}>{-lctrl}{c}{+lctrl}{p}{-lshift}{p}{+lshift}{enter}
{kp-lctrl}{pkmin}>{-lctrl}{c}{+lctrl}{p}{-lshift}{K}{+lshift}{enter}
{kp-lctrl}{kp8}>{-lctrl}{c}{+lctrl}{p}{-lshift}{L}{+lshift}{enter}
{kp-lctrl}{kp-r}>{-lctrl}{c}{+lctrl}{p}{r}
{kp-lctrl}{kp-f}>{-lctrl}{c}{+lctrl}{p}{f}
{kp-lctrl}{kp-d}>{-lctrl}{c}{+lctrl}{p}{d}
{kp-lctrl}{kp-b}>{-lctrl}{c}{+lctrl}{p}{b}
{kp-lctrl}{kp-e}>{-lctrl}{c}{+lctrl}{p}{e}
{kp-lctrl}{kp9}>{-lctrl}{c}{+lctrl}{p}{o}
{kp-lctrl}{kp-s}>{-lctrl}{c}{+lctrl}{p}{p}
{kp-lctrl}{kp-a}>{-lctrl}{c}{+lctrl}{p}{a}
{kp-lalt}{kp-y}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{w}{o}{r}{k}{s}{p}{a}{c}{e}{hyphen}{r}{e}{s}{t}{a}{r}{t}{enter}
{kp-lalt}{kp-z}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{w}{o}{r}{k}{s}{p}{a}{c}{e}{hyphen}{s}{h}{u}{t}{d}{o}{w}{n}{enter}
{kp-lalt}{kp-r}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{r}{e}{n}{a}{m}{e}{enter}
{kp-lalt}{kp-f}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{f}{o}{r}{m}{a}{t}{hyphen}{r}{e}{g}{i}{o}{n}{enter}
{kp-lalt}{kp-b}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{f}{o}{r}{m}{a}{t}{hyphen}{b}{u}{f}{f}{e}{r}{enter}
{kp-lalt}{kp-d}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{f}{i}{n}{d}{hyphen}{d}{e}{f}{i}{n}{i}{t}{i}{o}{n}{enter}
{kp-lalt}{kp-t}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{f}{i}{n}{d}{hyphen}{t}{y}{p}{e}{hyphen}{d}{e}{f}{i}{n}{i}{t}{i}{o}{n}{enter}
{kp-lalt}{kp-left}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{f}{i}{n}{d}{hyphen}{r}{e}{f}{e}{r}{e}{n}{c}{e}{s}{enter}
{kp-lalt}{kp-right}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{f}{i}{n}{d}{hyphen}{d}{e}{c}{l}{a}{r}{a}{t}{i}{o}{n}{enter}
{kp-lalt}{kp-down}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{t}{r}{e}{e}{m}{a}{c}{s}{hyphen}{c}{a}{l}{l}{hyphen}{h}{i}{e}{r}{a}{r}{c}{h}{y}{enter}
{kp-lalt}{kp-up}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{f}{i}{n}{d}{hyphen}{i}{m}{p}{l}{e}{m}{e}{n}{t}{a}{t}{i}{o}{n}{enter}
{kp-lalt}{kp0}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{s}{i}{g}{n}{a}{t}{u}{r}{e}{hyphen}{a}{c}{t}{i}{v}{a}{t}{e}{enter}
{kp-lalt}{kp-h}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{d}{e}{s}{c}{r}{i}{b}{e}{hyphen}{t}{h}{i}{n}{g}{hyphen}{a}{t}{hypen}{p}{o}{i}{n}{t}{enter}
{kp-lalt}{kp-s}>{-lalt}{x}{+lalt}{d125}{l}{s}{p}{hyphen}{t}{r}{e}{e}{m}{a}{c}{s}{hyphen}{s}{y}{m}{b}{o}{l}{s}{hyphen}{g}{o}{t}{o}{hyphen}{s}{y}{m}{b}{o}{l}{enter}
```

### Another alternate qwerty layout, called qwerty-a.txt

These bindings remap the end key to be same the same as foot pedal.

I use this as an alternative when traveling without a foot pedal when
extensively programming. I have to re-program the keyboard to use this alternate
layer and forgo the use of *end* for its traditional purposes, then switch the
keyboard back to the primary layout when I get home or when I want to use the
end key for its original purpose. This doesn't take long, read the keyboard
manual section on layers for the details.

```
[end]>[kpshift]
* rest of the content is same as above
```
