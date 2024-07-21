Connect-PowerBIServiceAccount
$workspaces = Get-PowerBIWorkspace -All
$exportPath = "C:\Path\To\Save\Reports"
if (-Not (Test-Path -Path $exportPath)) {
    New-Item -ItemType Directory -Path $exportPath
}
foreach ($workspace in $workspaces) {
    # Obtener informes en el espacio de trabajo
    $reports = Get-PowerBIReport -WorkspaceId $workspace.Id
    
    # Descargar cada informe
    foreach ($report in $reports) {
        $fileName = "$($workspace.Name)_$($report.Name).pbix"
        $fullPath = Join-Path -Path $exportPath -ChildPath $fileName
        try {
            Export-PowerBIReport -Id $report.Id -OutFile $fullPath
            Write-Output "Informe exportado: $fileName"
        } catch {
            Write-Output "Error al exportar: $fileName"
        }
    }
}