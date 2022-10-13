$uri = 'https://msautomationworkshop2022.blob.core.windows.net/master/students.zip?sp=r&st=2022-09-26T22:21:06Z&se=2023-09-20T06:21:06Z&spr=https&sv=2021-06-08&sr=b&sig=SBjKziwoCwPuDhy4HgtuU7O7Whz%2B5yqVvW3QaKB39ik%3D'

if (!(Test-Path C:\Temp)) {
    New-Item C:\Temp -ItemType 'Directory' -Force
}

Invoke-WebRequest -Uri $uri -UseBasicParsing -OutFile C:\Temp\students.zip

Expand-Archive -Path C:\Temp\students.zip -DestinationPath C:\Temp\Students -Verbose

$sources = "C:\Temp\Students\Students\Labs", "C:\Temp\Students\Students\Slides"

foreach ($source in $sources) {
    $robocopyCmd = "$source $($source.Replace('\Temp\Students\Students','')) /E /XC /XO /XN"
    Write-Output $robocopyCmd
    Start-Process -FilePath robocopy -ArgumentList $robocopyCmd | Out-Null
}