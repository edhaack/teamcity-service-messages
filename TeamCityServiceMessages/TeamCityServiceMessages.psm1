# Summary: Simple TC build log messages, based on the documentation.
# Notes: Reference this for more info: https://www.jetbrains.com/help/teamcity/service-messages.html
# Author: Ed Haack (email@edhaack.net)
function TeamCityBuildProblem([string] $message) {
	$message = TeamCityMessageDelimit $message
	"##teamcity[buildProblem description='{0}']" -f $message
}
function TeamCityBuildStatus([string] $status, [string] $message) {
	switch ($status.ToLower()) {
		"error" { TeamCityBuildProblem $message; break }
		"cancel" { TeamCityCancelBuild $message; break }
		Default {
			$message = TeamCityMessageDelimit $message
			"##teamcity[buildStatus status='SUCCESS' text='{0}']" -f $message
		}
	}
}
function TeamCityTestSuiteStart([string] $suiteName) {
	$suiteName = TeamCityMessageDelimit $suiteName
	"##teamcity[testSuiteStarted name='{0}']" -f $suiteName
}
function TeamCityTestSuiteFinished([string] $suiteName) {
	$suiteName = TeamCityMessageDelimit $suiteName
	"##teamcity[testSuiteFinished name='{0}']" -f $suiteName
}
function TeamCityTestStarted([string] $testName) {
	$testName = TeamCityMessageDelimit $testName
	"##teamcity[testStarted name='{0}']" -f $testName
}
function TeamCityTestFinished([string] $testName) {
	$testName = TeamCityMessageDelimit $testName
	"##teamcity[testFinished name='{0}']" -f $testName
}
function TeamCityTestOut([string] $testName, [string] $message) {
	$message = TeamCityMessageDelimit $message
	"##teamcity[testStdOut name='{0}' out='{1}']" -f $testName, $message
}
function TeamCityTestErr([string] $testName, [string] $message) {
	$message = TeamCityMessageDelimit $message
	"##teamcity[testStdErr name='{0}' out='{1}']" -f $testName, $message
}
function TeamCityTestIgnore([string] $testName, [string] $message) {
	$message = TeamCityMessageDelimit $message
	"##teamcity[testIgnored name='{0}' out='{1}']" -f $testName, $message
}
function TeamCityTestFailed([string] $testName, [string] $message, [string] $details, [string] $expected, [string] $actual) {
	$message = TeamCityMessageDelimit $message
	$details = TeamCityMessageDelimit $details
	$expected = TeamCityMessageDelimit $expected
	$actual = TeamCityMessageDelimit $actual
	"##teamcity[testFailed type='comparisonFailure' name='{0}' message='{1}' details='{2}' expected='{3}' actual='{4}']" -f $testName, $message, $details, $expected, $actual
}
function TeamCityPublishArtifact([string] $filePath) {
	"##teamcity[publishArtifacts '$filePath']";
}
function TeamCityBlockOpen([string] $blockName, [string] $description) {
	$description = TeamCityMessageDelimit $description;
	"##teamcity[blockOpened name='{0}' description='{1}']" -f $blockName, $description;
}
function TeamCityBlockClose([string] $blockName) {
	$blockName = TeamCityMessageDelimit $blockName;
	"##teamcity[blockClosed name='{0}']" -f $blockName;
}
function TeamCitySetParameter([string] $parameterName, [string] $parameterValue) {
	$parameterValue = TeamCityMessageDelimit $parameterValue;
	"##teamcity[setParameter name='{0}' value='{1}']" -f $parameterName, $parameterValue;
}
function TeamCityCancelBuild([string] $parameterComment, [bool] $parameterReAddToQueue = $false) {
	[String] $comment = TeamCityMessageDelimit $parameterComment
	[String] $reAddToQueue = $parameterReAddToQueue
	"##teamcity[buildStop comment='{0}' readdToQueue='{1}']" -f $comment, $reAddToQueue.ToLower()
}
function TeamCityProgressStart([string] $parameterMessage) {
	$parameterMessage = TeamCityMessageDelimit $parameterMessage
	"##teamcity[progressStart comment='{0}']" -f $parameterMessage
}
function TeamCityProgressFinish([string] $parameterMessage) {
	$parameterMessage = TeamCityMessageDelimit $parameterMessage
	"##teamcity[progressFinish comment='{0}']" -f $parameterMessage
}
function TeamCityProgressMessage([string] $parameterMessage) {
	$parameterMessage = TeamCityMessageDelimit $parameterMessage
	"##teamcity[progressMessage  comment='{0}']" -f $parameterMessage
}
function TeamCityBuildNumber([string] $parameterNewBuildNumber) {
	$parameterNewBuildNumber = TeamCityMessageDelimit $parameterNewBuildNumber
	"##teamcity[buildNumber  '{0}']" -f $parameterNewBuildNumber
}

function TeamCityMessageDelimit([string] $rawMsg) {
	#Delimit char is a | pipe
	$message = $rawMsg.replace("|", "||")
	$message = $message.replace("'", "|'")
	$message = $message.replace("`n", "|n")
	$message = $message.replace("\n", "|n")
	$message = $message.replace("`r", "|r")
	$message = $message.replace("\r", "|r")
	$message = $message.replace("[", "|[")
	$message = $message.replace("]", "|]")
	return $message
}

<#Module Stuff#>
Export-ModuleMember -function TeamCity*

# end of line.