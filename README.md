# Cmdmarks

Directory bookmarks for Windows Command Prompt.

## Demo

Usage.

    $ cm help
    [Usage]
    cm          : List all bookmarks.
    cm add      : Add the current directory as bookmark.
    cm edit     : Open the datafile with your editor.
    cm check    : Check pathes in the datafile and alert if an error exists.
    cm (NUMBER) : Goes (pushd) to the directory matched the number.
    cm (QUERY)  : Goes (pushd) to the directory matched the query.

Add.

    $ cd
    D:\work\github\stakiran\cmdmarks
    
    $ cm
     1: c:\windows
     2: c:\program files
     2 bookmarks.

    $ cm add
    Add "D:\work\github\stakiran\cmdmarks" as bookmark.

    $ cm
     1: c:\windows
     2: c:\program files
     3: D:\work\github\stakiran\cmdmarks
     3 bookmarks.

Go. (number matching)

    $ cm 1
    pushd c:\windows

    $ cd
    c:\Windows

Go. (query matching)

    $ cm sta
    pushd D:\work\github\stakiran\cmdmarks

    $ cd
    D:\work\github\stakiran\cmdmarks

Edit and Check.

    $ cm
     1: c:\windows
     2: c:\program files
     3: D:\work\github\stakiran\cmdmarks
     3 bookmarks.

    $ cm edit

    $ cm
     1: c:\windows
     2: c:\program files
     3: c:\program files\invalidpath
     4: D:\work\github\stakiran\cmdmarks
     5: c:\invalidpath
     5 bookmarks.

    $ cm check
     3: c:\program files\invalidpath
     5: c:\invalidpath
     2 invalid directories.

## Installation

1. git clone https://github.com/stakiran/cmdmarks
2. Add cmdmarks directory to the PATH.

## Where Cmdmarks are stored

All of your directory bookmarks are saved in "cmdmark_list.txt".

# License

[MIT License](LICENSE)

# Author

[stakiran](https://github.com/stakiran)
