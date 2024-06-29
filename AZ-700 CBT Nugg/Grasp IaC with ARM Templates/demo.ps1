Login-AzAccount

Get-AzSubscription | Where-Object { $_.Name -eq "Azure NFL Lab" } | Select-AzSubscription