<# 
 .Synopsis
  Ensures the latest NuGet packages are installed for a solution without interfering non-LevelUp packages.

 .Description
  1. Runs the NuGet cache clear command
  2. Removes LevelUp packages from the root \packages\ directory
  3. Calls NuGet restore on the solution to ensure the latest packages were re-resolved


 .Example
   # Show a default display of this month.
   Clear-LevelUpNuGet
#>
function Get-CurrentDirectory {
  (Get-Item -Path ".\" -Verbose).FullName
}

function Get-SolutionFiles($path) {
  Get-ChildItem -File | Where-Object {$_.extension -eq ".sln"}
}

function Read-SolutionExists {
  $cwd = Get-CurrentDirectory
  $slnFiles = Get-SolutionFiles $cwd

  return $slnFiles.Count
}

function Clear-NuGetCache {
  nuget.exe locals -clear all  
}

function Clear-LevelUpPackages {
  # If the current directory has a \packages\ directory
  # Navigate within it and delete all 'LevelUp-*' files
  $CurrentPath = Get-CurrentDirectory
  $PackagesPath = join-path -path $CurrentPath -ChildPath "packages"

  Get-ChildItem -Path "$PackagesPath" -Filter "*LevelUp*" | Where-Object { $_.PSIsContainer } |
    Foreach-Object { 
    Remove-Item $_.FullName -Recurse 
  }
}

function Restore-NuGetPackages {
  # Call 'nuget restore' on the solution file
  $CurrentPath = Get-CurrentDirectory
  $SlnFiles = Get-SolutionFiles $CurrentPath
  
  $SlnFiles | 
    Foreach-Object {  
    nuget restore $_.FullName
  }
}

function Reset-LevelUpNuGet {
  $result = Read-SolutionExists

  if ($result -eq $FALSE) {
    Write-Host "Exiting - there are no .sln files in the current directory."
  }
  else {
    Write-Host "Clearing NuGet HTTP cache, NuGet cache, and NuGet global packages cache..."
    Clear-NuGetCache

    Write-Host "Clearing local LevelUp packages..."
    Clear-LevelUpPackages

    Write-Host "Restoring NuGet packages..."
    Restore-NuGetPackages

    Write-Host "Complete."
  }  
}

# Export the module
Export-ModuleMember -Function Reset-LevelUpNuGet