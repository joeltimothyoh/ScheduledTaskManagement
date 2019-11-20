# ScheduledTaskManagement

[![badge-build-azuredevops-build-img][]][badge-build-azuredevops-build-src] [![badge-version-github-release-img][]][badge-version-github-release-src] [![badge-version-powershellgallery-releases-img][]][badge-version-powershellgallery-releases-src]

[badge-build-azuredevops-build-img]: https://img.shields.io/azure-devops/build/joeltimothyoh/ScheduledTaskManagement/19/master.svg?label=build&logo=azure-pipelines&style=flat-square
[badge-build-azuredevops-build-src]: https://dev.azure.com/joeltimothyoh/ScheduledTaskManagement/_build?definitionId=19
[badge-version-github-release-img]: https://img.shields.io/github/v/release/joeltimothyoh/ScheduledTaskManagement?style=flat-square
[badge-version-github-release-src]: https://github.com/joeltimothyoh/ScheduledTaskManagement/releases
[badge-version-powershellgallery-releases-img]: https://img.shields.io/powershellgallery/v/ScheduledTaskManagement?logo=powershell&logoColor=white&label=PSGallery&labelColor=&style=flat-square
[badge-version-powershellgallery-releases-src]: https://www.powershellgallery.com/packages/ScheduledTaskManagement/

## Introduction

A PowerShell module for non-interactive management of Scheduled Tasks.

## Requirements

* **Windows** with [PowerShell](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-windows-powershell?view=powershell-6).

## Installation

First, ensure [`PSGallery`](https://www.powershellgallery.com/) is registered as a PowerShell repository:

```powershell
Register-PSRepository -Default -Verbose
```

To install the module:

```powershell
# Latest, for the current user
Install-Module -Name ScheduledTaskManagement -Repository PSGallery -Scope CurrentUser -Verbose

# Specific version, for the current user
Install-Module -Name ScheduledTaskManagement -Repository PSGallery -RequiredVersion x.x.x -Scope CurrentUser -Verbose

# Latest, for all users
Install-Module -Name ScheduledTaskManagement -Repository PSGallery -Scope AllUsers -Verbose
```

## Usage

### Functions

#### Parameters

```powershell
Setup-ScheduledTask -DefinitionFile <string[]> [-AsJson] [<CommonParameters>]

Setup-ScheduledTask -DefinitionDirectory <string[]> [-AsJson] [<CommonParameters>]

Setup-ScheduledTask -DefinitionObject <Object[]> [<CommonParameters>]
```

#### Examples

```powershell
# Via .ps1 definition file
Setup-ScheduledTask -DefinitionFile "C:\path\to\definition.ps1"

# Via .json definition file
Setup-ScheduledTask -DefinitionFile "C:\path\to\definition.json" -AsJson

# Via directory containing .ps1 definition files
Setup-ScheduledTask -DefinitionDirectory "C:\path\to\definition\directory\"

# Via directory containing .json definition files
Setup-ScheduledTask -DefinitionDirectory "C:\path\to\definition\directory\" -AsJson

# Via definition objects
$tasks = . "C:\path\to\definition.ps1"
Setup-ScheduledTask -DefinitionObject $tasks
```

To list all available functions of the module:

```powershell
Get-Command -Module ScheduledTaskManagement
```

## Administration

### Versions

To list versions of the module on `PSGallery`:

```powershell
# Latest
Find-Module -Name ScheduledTaskManagement -Repository PSGallery -Verbose

# All versions
Find-Module -Name ScheduledTaskManagement -Repository PSGallery -AllVersions -Verbose
```

To update the module (**Existing versions are left intact**):

```powershell
# Latest
Update-Module -Name ScheduledTaskManagement -Verbose

# Specific version
Update-Module -Name ScheduledTaskManagement -RequiredVersion x.x.x -Verbose
```

To uninstall the module:

```powershell
# Latest
Uninstall-Module -Name ScheduledTaskManagement -Verbose

# All versions
Uninstall-Module -Name ScheduledTaskManagement -AllVersions -Verbose

# To uninstall all other versions other than x.x.x
Get-Module -Name ScheduledTaskManagement -ListAvailable | ? { $_.Version -ne 'x.x.x' } | % { Uninstall-Module -Name $_.Name -RequiredVersion $_.Version -Verbose }

# Tip: Simulate uninstalls with -WhatIf
```

### Repositories

To get all registered PowerShell repositories:

```powershell
Get-PSRepository -Verbose
```

To set the installation policy for the `PSGallery` repository:

```powershell
# PSGallery (trusted)
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted -Verbose

# PSGallery (untrusted)
Set-PSRepository -Name PSGallery -InstallationPolicy Untrusted -Verbose
```

### Development

To import / re-import the module:

```powershell
# Installed version
Import-Module -Name ScheduledTaskManagement -Force -Verbose

# Project version
Import-Module .\src\ScheduledTaskManagement\ScheduledTaskManagement.psm1 -Force -Verbose
```

To remove imported functions of the module:

```powershell
Remove-Module -Name ScheduledTaskManagement -Verbose
```

To list imported versions of the module:

```powershell
Get-Module -Name ScheduledTaskManagement
```

To list all installed versions of the module available for import:

```powershell
Get-Module -Name ScheduledTaskManagement -ListAvailable -Verbose
```
