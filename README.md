# TeamCity Service Messages: PowerShell Helper Module

Collection of methods to help with build log service messages

## Install

Copy this module into **one** of the following directories:

Windows PowerShell:

- All Users: `%ProgramFiles%\WindowsPowerShell\Modules`
- Current User: `%UserProfile%\Documents\WindowsPowerShell\Modules`

PowerShell Core:

- Windows: All Users: `%ProgramFiles%\PowerShell\7\Modules`
- Windows: Current User: `%UserProfile%\Documents\PowerShell\Modules`
- Linux: `/opt/microsoft/powershell/7/Modules`

## Methods & Usage

### Common Messages

- TeamCityPublishArtifact([string] $filePath)
- TeamCitySetParameter([string] $parameterName, [string] $parameterValue)
- TeamCityBuildProblem([string] $message)
- TeamCityBuildStatus([string] $status, [string] $message)
- TeamCityCancelBuild([string] $parameterComment, [bool] $parameterReAddToQueue = $false)
- TeamCityBuildNumber([string] $parameterNewBuildNumber)

### Message Blocks

- TeamCityBlockOpen([string] $blockName, [string] $description)
- TeamCityBlockClose([string] $blockName)

### Testing

- TeamCityTestSuiteStart([string] $suiteName)
- TeamCityTestSuiteFinished([string] $suiteName)
- TeamCityTestStarted([string] $testName)
- TeamCityTestFinished([string] $testName)
- TeamCityTestOut([string] $testName, [string] $message)
- TeamCityTestErr([string] $testName, [string] $message)
- TeamCityTestIgnore([string] $testName, [string] $message)
- TeamCityTestFailed([string] $testName, [string] $message, [string] $details, [string] $expected, [string] $actual)

### Progress Messages

- TeamCityProgressStart([string] $parameterMessage)
- TeamCityProgressFinish([string] $parameterMessage)
- TeamCityProgressMessage([string] $parameterMessage)

## Notes

These methods work with both Microsoft PowerShell 2 through 5.1 and PowerShell 7 (Core), without any modification.
