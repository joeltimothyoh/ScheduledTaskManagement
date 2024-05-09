Describe "ScheduledTaskManagement" -Tag 'Integration' {
    BeforeAll {
        $moduleDir = $PSScriptRoot
        Import-Module $moduleDir/ScheduledTaskManagement.psm1 -Force
        $testDir = "$moduleDir\..\..\test"
    }
    BeforeEach {
        Push-Location $testDir
    }
    AfterEach {
        $script:stdout | Out-String -Stream | % { $_.Trim() } | ? { $_ } | Write-Host
        Pop-Location
    }
    It "Runs Setup-ScheduledTask -DefinitionFile" {
        $script:stdout = Setup-ScheduledTask -DefinitionFile "definitions\scheduledtasks\tasks-1.ps1"
    }
    It "Runs Setup-ScheduledTask -DefinitionFile -AsJson" {
        $script:stdout = Setup-ScheduledTask -DefinitionFile "definitions\scheduledtasks\tasks-1.json" -AsJson
    }
    It "Runs Setup-ScheduledTask -DefinitionDirectory" {
        $script:stdout = Setup-ScheduledTask -DefinitionDirectory "definitions\scheduledtasks\"
    }
    It "Runs Setup-ScheduledTask -DefinitionDirectory -AsJson" {
        $script:stdout = Setup-ScheduledTask -DefinitionDirectory "definitions\scheduledtasks\" -AsJson
    }
    It "Runs Setup-ScheduledTask -DefinitionObject" {
        $tasks = . ".\definitions\scheduledtasks\tasks-1.ps1"
        $script:stdout = Setup-ScheduledTask -DefinitionObject $tasks
    }
    It "Runs `$tasks | Setup-ScheduledTask from .ps1 definition file" {
        $tasks = . ".\definitions\scheduledtasks\tasks-1.ps1"
        $script:stdout = $tasks | Setup-ScheduledTask
    }
    It "Runs `$tasks | Setup-ScheduledTask from .json definition file" {
        $tasks = Get-Content "definitions\scheduledtasks\tasks-1.json" | ConvertFrom-Json | % { $_ }
        $script:stdout = $tasks | Setup-ScheduledTask
    }
    It "Runs `$tasks | Setup-ScheduledTask from directory containing .ps1 definition file(s)" {
        $tasks = Get-ChildItem "definitions\scheduledtasks\" -File | ? { $_.Extension -eq '.ps1' } | % { . $_.FullName }
        $script:stdout = $tasks | Setup-ScheduledTask
    }
    It "Runs `$tasks | Setup-ScheduledTask from directory containing .json definition file(s)" {
        $tasks = Get-ChildItem "definitions\scheduledtasks\" -File | ? { $_.Extension -eq '.json' } | % { Get-Content $_.FullName | ConvertFrom-Json | % { $_ } }
        $script:stdout = $tasks | Setup-ScheduledTask
    }
}
