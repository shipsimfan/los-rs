# Lance Operating System
A hobby operating system written for modern x86-64 systems in rust.

## Build Requirements
Lance OS is dependent on a few programs in order to build:
 * [Rust](https://www.rust-lang.org/) (Nightly with sources)
 * [LOS Compatible Clang](https://github.com/shipsimfan/llvm-los)
 * [NASM](https://www.nasm.us/)
 * Make
 * AR
 * [losb](https://github.com/shipsimfan/losb)

## Running Requirements
Lance OS has the current system requirements:
 * Any x86-64 CPU
 * A UEFI bios
 * PS/2 or USB PS/2 emulated keyboard
 * 8259 Compatible PICs*
 * ACPI 2.0+*
 * An HPET*

(*) Almost any system with the first two requirements meet all of these.

## How to Build
Before building to project, you must initialize the submodules.
```sh
git submodule init
git submodule update --remote
```
This only needs to be performed once. Only the second line can then be used to
update the submodules.

losb is used to build Lance OS. Using losb is simple. To build Lance OS into a
hard disk image, run the following command:
```sh
losb build-image
```

Other sub commands of losb can be viewed with:
```sh
losb help
```
