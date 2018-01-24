
# levelup-powershell-nuget-reset

This project add's the `Reset-LevelUpNuGet` command to your shell.

## Getting Started

### Installing

First, clone this repository. Take note of the file location.

```
c:\...\levelup-powershell-nuget-reset\Reset-LevelUpNuGet.psm1
```

Locate your powershell profile, we need to edit it.

```
C:\> $profile
C:\Users\firstname.lastname\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
```

Even open it in notepad.

```
C:\> notepad $profile
```

Add the (following) `Import-Module` command to your profile.

```
Import-Module "C:\...\levelup-powershell-nuget-reset\Reset-LevelUpNuGet.psm1"
```

Finished. Restart any shell instances.

### Usage

Note: The `Reset-LevelUpNuget` function must be used in a directory with a `.sln` file.

#### Example - Invalid directory

```
C:\> Reset-LevelUpNuGet
Exiting - there are no .sln files in the current directory.
```

#### Example - Valid directory

```
C:\Projects\TheLevelUp\pos-ncr-aloha [master]> Reset-LevelUpNuGet
Clearing NuGet HTTP cache, NuGet cache, and NuGet global packages cache...
Clearing NuGet HTTP cache: C:\Users\forest.balk\AppData\Local\NuGet\v3-cache
Clearing NuGet global packages cache: C:\Users\forest.balk\.nuget\packages\
Clearing NuGet Temp cache: C:\Users\forest.balk\AppData\Local\Temp\NuGetScratch
Local resources cleared.
Clearing local LevelUp packages...
MSBuild auto-detection: using msbuild version '15.5.180.51428' from 'C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\bin'.

...
...
...

Complete.
```