''
Write-Host -######################################################################-
Write-Host -####################- " מתחיל ניטור יציבות, אינדקסים ותופעות ... נא המתן" -###############################-
Write-Host -######################################################################-
''
$First_Measure = Get-Ciminstance Win32_ReliabilityStabilityMetrics |
Measure-Object -Average -Maximum  -Minimum -Property systemStabilityIndex
$First_Measure
if ($First_Measure.Average -gt 5.9)
{Write-Host "יש לבדוק.."
Start-Sleep -Seconds 20}
else
{Write-Host "הכל בסדר, ממשיך בבדיקה"}
''

Write-Host -######################################################################-
Write-Host -####################- " מתחיל ניטור אירועים ובעיות אפליקטיביות לאחרונה ... נא המתן" -###############################-
Write-Host -######################################################################-
''

Start-Sleep -Seconds 3
$Second_Measure = Function Get-SortedReliabilityRecords

{

 Param ([string]$computer = “.”)

 Get-WmiObject -Class win32_reliabilityRecords -ComputerName $computer |

 Group-Object -Property sourcename, eventidentifier, ProductName -NoElement |

 Sort-Object -Descending count |

 Format-Table -AutoSize -Property count, 

  @{Label = “Source, EventID, ProductName”;Expression = {$_.name} }

}
Get-SortedReliabilityRecords


Start-Sleep -Seconds 3
''
Write-Host -######################################################################-
Write-Host -####################- " מתחיל בדיקה זמן - בדיקה אחרונה ... נא המתן" -###############################-
Write-Host -######################################################################-
''
$Problem_Name1 = Read-Host "What is the program name? "

Start-Sleep -Seconds 3

Get-CimInstance -ClassName Win32_ReliabilityRecords -Filter "ProductName=$Problem_Name1" |

Select timegenerated |

Sort -Descending
