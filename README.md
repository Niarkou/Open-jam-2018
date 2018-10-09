# Joe Pickle

A game by Sam Hocevar and Claire Plantet for [Open Jam 2018](https://itch.io/jam/open-jam-2018).

Joe Pickle lives in a fridge. He likes spam. But tomatoes try to prevent him
from enjoying his spam. Defeat the tomatoes! At the end, there is **SPAM TO
WIN**!

Controls:

 * Z to start game
 * Z to shoot
 * Arrows to move, X to jump

Note: on AZERTY keyboards, replace Z with W.

## Run using PICO-8

[PICO-8](https://www.lexaloffle.com/pico-8.php) is a fantasy console for Linux,
Windows an Mac that you can purchase for $14.99. Just run it and load the
`joepickle.p8` cartridge.

## Run using ZEPTO-8

[ZEPTO-8](https://github.com/samhocevar/zepto8) is an **open source PICO-8
emulator**. It is provided as a submodule in this Git repository. In order to
build it, make sure all the submodules are pulled, for instance with the Git
command line:

    git submodule update --init --recursive

The build procedure on Linux is as follows:

    ./bootstrap
    ./configure
    make -j

On Windows, open the `zepto8.sln` solution using Visual Studio 2017 (both the
Professional and Community editionrs are known to work).

Once built, the player is called `z8player`, run it with the cartridge as an argument:

    ./z8player joepickle.p8

## Technologies

Joe Pickle runs on Linux, Windows, and in any web browser.

Open Source tools used to create this game:
   * [The Gimp](https://www.gimp.org/)
   * [Vim](https://www.vim.org/)
   * [Visual Studio Code](https://code.visualstudio.com/)
   * [midi2pico8](https://github.com/samhocevar/fork-rtmidi/tree/midi2pico8), a MIDI input tool for PICO-8

## Licensing

 * All code and artwork are released under the [WTFPL](http://www.wtfpl.net/) open source license.

