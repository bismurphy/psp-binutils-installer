This script fetches and builds a version of binutils meant for use with the Playstation Portable console.

Simply run the script and it will do everything.

This was developed for the purpose of getting a PSP-compatible assembler (`psp-as`), which you can find in the `pspdev/bin` directory after running the script.

The script originates from `https://github.com/pspdev/psptoolchain-allegrex/tree/main` and has been modified to do a minimal process, as far as I could manage.

It would be highly preferrable to modify the make targets to only make the assembler, rather than everything in the binutils suite, but I can't figure out how to do that. I tried changing the `make all` in the script to `make gas` but it failed.
