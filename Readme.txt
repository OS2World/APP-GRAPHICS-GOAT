GOAT beta 0.06 (formerly OCRE) Copyright Jason Stefanovich, 2002

GOAT is an acronym for Graphics Optical Analysis & Translation.
This program, in conjunction with GOCR (GNU OCR) and portions of the NetPBM package, will allow you to import
scanned text, manipulate it, and produce text output with just a few clicks of the mouse.

The following graphics formats are supported (open/save):
PNM BMP VGA RLE DIB RL4 RL8 GIF PCX TIF TGA VST AFI IFF LBM VID KPS IAX XBM SPR SPRITE PSE PSEG PSEG38PP
PSEG3820
The following text formats are supported:
Open: ASCII
Save: ISO8859.1, TeX, HTML


New in this version
*  Fix for all problematic and invalid hotkeys
*  Update to external editor configuration window to allow "%s" variable for file name in the
   parameters fields
*  Start of help documentation
*  Fixed some issues with program close

New in 0.05c
* Menu shortcuts and hotkeys have been added
* Window Views now work

New in 0.05b
* Fix for program crash when multiple OCR Configuration windows are open and image is scanned

New in 0.05a
* Image scaling now works correctly
* Temp file cleanup
* OCR on selected region now works
* Confirmation on program exit
* Bogus headder removed from text printout
* All toolbar buttons should function now

New in 0.05
* Image Scaling
* Some memory management fixes
* Coding for OCR on selected region (incomplete)
* Menu updates

New in 0.04
* GOCR configuration menu
* INI file auto-create

New in 0.03:
* Support for multiple output types
* Support for external editors (with autorun capabilities)
* Fix so that temp files are dumped in GOAT's directory and not that of the original image
* Some menu changes

Known problems/limitations:
* FIXED: Scale image code is implemented but not functioning (suspect bug in library).
  Scaling has now been implemented with the "Set Image Attributes" method.
* Single bit Tiffs are output inversely (suspect bug in library)
* FIXED: Some buttons only have stubs right now (except for Help)
* Rotate function does not behave as expected
* GOCR accepts but does not honor output format options other than ISO
* FIXED: External editor calls are limited to "program.exe myfile parameters" at this time
  Now supports "%s" variable for file name
* FIXED: when using verbose modes, GOCR sends the timestamp to STDOUT instead of STDERR (bug)
  This has been fixed.  Thanks Joerge!
* Image Editor "Set Selected" method does not work *AT ALL*.  Verification?


To install:
1.  download GOAT 0.06 and unzip into an installation directory
2.  download the current version of GOCR for OS/2 and unzip it in the same directory
3.  it is assumed that you already have installed emx 0.9d (required for NetPBM)
4.  run GOAT.exe to start
5.  included is a sample 'a.pnm' to test the functionality

This is a very early beta, most features are not locked in yet and those that are may not be fully functional.
Hopefully this program should be easy to understand as the help file is not complete.
If you click something and it seems like it did nothing...you're probably right.  If you click something and
it seems like it started to do something but produced no results...check the error.log.
This program should not crash, but if it does, please copy the ouput of the STDIO error window and send it to
the OS2-OCR group at http://groups.yahoo.com/group/OS2-OCR/ or email me directly at stefanj@gte.net.

GOCR is covered by the GNU Public License.

Parts of the NetPBM package are used with this program.  Please refer to NetPBM.txt for terms and conditions.

As always...
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
