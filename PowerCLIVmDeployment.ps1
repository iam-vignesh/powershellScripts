#function to ignore security cert error and connect to vSphere
function connectToServer
{
Write-Host "Connecting to server...Please wait!"
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false | Out-Null
Connect-VIServer -Server "serverURLGoesHere" -protocol https -user "userName" -password "password" 
Write-Host "Connected!"
Start-Sleep(3)
Clear-Host
}

#function to deploy VM from the selected template
function createVMFromTemplate
{
    
    Write-Host "Virtual Machine build in progress..."
    try{
        New-VM -Name $newvmName -Template $templateName -ResourcePool $resourcePool -Datastore $dataStore -Location $location -VMHost $esxi -ErrorAction Stop  |Set-VM -NumCpu 4 -MemoryGB 8 -Confirm:$false | Out-Null
        Write-Host "Build Successfull..!"
        Get-VM $newvmName
    }
    catch {
        Write-Host "Build Failed!"
    }
    
}

#function call to connect to the server
connectToServer

$selectionMenu = Write-Host @"
- - - M E N U - - -
1. Create VM from template
2. Create VM from scratch
"@

$selection = Read-Host "Please enter your selection: "

#static environment data
$resourcePool = "rpName"
$esxi = "esxiName"
$dataStore = "datastoreName"
$location = "locationName"

if($selection -eq 1){
    Write-Host "Creating VM from templates..."
    $allTemplates = Get-Template
    $count = 0
    Write-Host "--T E M P L A T E S--"
        foreach($template in $allTemplates)
            {
                Write-Host $count"."$template    
                $count++
            }
        [int]$templateSelection = Read-Host "Enter the template number: "
        $templateName = $allTemplates[$templateSelection]
        $newvmName = Read-Host "Please enter a unique VM name: "
        createVMFromTemplate            #calling the function
     #scratchVMfunctiongoeshere   
}




