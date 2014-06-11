lrs-maker
=========

A little program for creating Lazarus resource files to allow to embed a file in the program. This has been created for Lazarus IDE users. From: http://lazplanet.blogspot.com .

The program creates .lrs file out of a normal file. It is appropriate for Lazarus programs. It uses lazres.exe to generate the resource file. It is basically a GUI for the lazres.exe. lazres.exe has been built from sources. But you can easily build it from c:\lazarus\tools\lazres\lazres.lpi. Free pascal/Lazarus has other types of resources. Information about those can be found here: http://wiki.lazarus.freepascal.org/Lazarus_Resources . If you want to embed multiple files, then may be using a .rc file is better.

### How to use

1. Open the LRSMaker.exe program. Browse and select the file you want to embed to the exe. Then select the .lrs file to be created. Keep the file in the project directory. Then click "Generate LRS file" to generate lrs file. If it is successful you will see instructions on the output text memo. Take a note of the ResourceName. You will need it later when you will code.

2. Add LResources to the uses clause.
```pascal
uses
  ...LResources...;
```

3. Add it under the initialization clause
```pascal
initialization
  {$I mylazarusresource.lrs}
```
Note that the lrs file will be embedded during building the exe and this file will not be needed in the distribution.

4. Use the resource
```pascal
Image1.Picture.LoadFromLazarusResource('image'); // Image1 is a TImage. Replace image with your ResourceName from output of LRSMaker
```

