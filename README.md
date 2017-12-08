# nss-nspr-windows

Mozilla NSS and NSPR set up to be built for Windows (Vista and later) with Visual Studio 2017.

**Network Security Services (NSS)** is a set of libraries designed to support cross-platform development of security-enabled
client and server applications. For more information, see https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSS.

**Netscape Portable Runtime (NSPR)** provides a platform-neutral API for system level and libc-like functions
and is required to build NSS. See https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSPR.

This repository contains following stable releases:
* NSPR 4.17
* NSS 3.34.1

Sources were patched to fix minor Windows-specific build errors. 

## Pre-built libraries

Normally you don't need to compile the libraries yourself. You can just download the zip archive from the **prebuilt** directory.
The archive contains include files, .lib files, .dll's and tools, that is everything needed to use NSS+NSPR in your program.
Both debug and release builds are included, as well as both 32-bit and 64-bit platforms.

To run tools, you'll need to copy .dll's to "bin" directory or keep them somewhere in your PATH.

Following sections are applicable if you are going to compile libraries yourself.

## Required software

1. Visual Studio 2017 with C++ support, x86 and amd64 platforms, Windows 8.1 or 10 SDK, and ATL (not tested with other versions)
2. Mozilla Build suite: https://wiki.mozilla.org/MozillaBuild

## Usage

1. In **build.cmd**, change the paths to Visual Studio helper files and Mozilla Build suite (if your paths differ from defaults).
2. Run **build.cmd**.
3. Run **test.cmd** if you want to run tests (can take a very long time).
4. Run **powershell -file create-prebuilt-archive.ps1** to create the pre-built zip archive.

## Known issues

1. During one of build stages, **shlibsign** program may produce "Debug Assertion" dialogs. Just click "Ignore" in these dialogs.
2. NSS does not seem to support building statically, so you'll have to distribute all the DLL's with your program.

## References

https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSS/NSS_Sources_Building_Testing
