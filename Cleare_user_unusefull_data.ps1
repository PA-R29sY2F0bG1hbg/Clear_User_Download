#+-------------------------------------------------------------------+
#| = : = : = : = : = : = : = : = : = : = : = : = : = : = : = : = : = |  
#|{>/-------------------------------------------------------------\<}|           
#|: | Author:  Philippe-Alexandre Munch                           | :|           
#| :| Email:   ---------------------------------                  |: |
#|: | Purpose: Clear_User_Download                                | :|
#| :|                                                             |: |  
#|: |                                                             | :|  
#| :|                                                             |: |      
#|: |         		                                              | :|  
#|: |                                                             |: |  
#| :| 	/^(o.o)^\    Version:1.0             	                  | :|
#|{>\-------------------------------------------------------------/<}|
#| = : = : = : = : = : = : = : = : = : = : = : = : = : = : = : = : = |
#+-------------------------------------------------------------------+

#################
# LOAD ASSEMBLY #
#################
Add-Type -AssemblyName Microsoft.VisualBasic
[void][reflection.assembly]::LoadWithPartialName("System.Windows.Forms")
[reflection.assembly]::LoadWithPartialName( "System.Windows.Forms")
[reflection.assembly]::LoadWithPartialName( "System.Drawing")
[System.Windows.Forms.Application]::EnableVisualStyles();

##########
# Object #
##########
$button1 = New-Object System.Windows.Forms.Button
$textbox1 = New-Object System.Windows.Forms.TextBox
$label1 = New-Object System.Windows.Forms.Label
$label2 = new-object System.Windows.Forms.Label
$label3 = New-Object System.Windows.Forms.Label
$button2 = New-Object System.Windows.Forms.Button
$progressbar = New-Object System.Windows.Forms.ProgressBar
$splitter = New-Object System.Windows.Forms.Splitter
$menuMain = New-Object System.Windows.Forms.MenuStrip

########
# FORM #
########
$form = New-Object system.Windows.Forms.Form
$form.text = "Clear User Download"
$Form.StartPosition = "CenterScreen"
$Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::Fixed3D
$form.size = New-Object System.Drawing.size(700,500)
$form.Location = New-Object System.Drawing.Size(500,500)

############
# Var Used #
############
$getfolderlength = "{0:N2} MB" -f ((Get-ChildItem $ENV:USERPROFILE\Downloads -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum / 1MB)
$getitem = (Get-ChildItem -Path $ENV:USERPROFILE\Downloads | Measure-Object).Count;

#########
# Label #
#########
$label1.text = "Download files"
$label1.Font = "Bahnschrift,18"
$label1.AutoSize = $true
$label1.Location = New-Object System.Drawing.Size(20,25)


###########
# Label 2 #
###########
$label2.Text = "Cleanup the folder ?"
$label2.AutoSize = $true
$label2.Location = New-Object System.Drawing.Size(20,365)
$label2.Font = "Bahnschrift,10"

###########
# Label 3 # 
###########
$label3.Text = "Total size : $getfolderlength"
$label3.AutoSize = $true
$label3.Location = New-Object System.Drawing.Size(300,390)
$label3.Font  = "Bahnschrift,14"

################
# Progress Bar #
################
$progressbar  = New-Object System.Windows.Forms.ProgressBar
$progressbar.Maximum = 100
$progressbar.Minimum = 0
$progressbar.Size = New-Object system.Drawing.size(200,20)
$progressbar.Location = New-Object system.Drawing.size(300,420)
$i = 0

############
# Button 1 #
############
$button1.text = "Yes"
$button1.Size = New-Object System.Drawing.Size(50,20)
$button1.Location = New-Object System.Drawing.Size(20,390)
$button1.add_click({Remove-Item -Path $ENV:USERPROFILE\Downloads -Recurse

While ($i1 -le 100) {

    $progressbar.Value = $i1
    Start-Sleep -m 1
    "VALLUE EQ"
    $i1
    $i1 += 1
}

# recall varaible $getitem
$getitem = (Get-ChildItem -Path $ENV:USERPROFILE\Downloads | Measure-Object).Count;

# VB interact 
if ($getitem -eq 0){$popup1 = [Microsoft.VisualBasic.Interaction]::MsgBox("All File is deleted")}
if ($getitem -gt 0){$popup2 = [Microsoft.VisualBasic.Interaction]::MsgBox("All the file not been deleted, there is always $getitem file's")}
if ($positifm -match "OK"){Stop-Process -Name powershell}
if ($negatifm -match "ok"){Stop-Process -Name powershell} 
})

############
# Button 2 #
############
$button2.text = "No"
$button2.Size = New-Object System.Drawing.Size(50,20)
$button2.Location = New-Object System.Drawing.Size(80,390)
$button2.add_click({Stop-Process -Name powershell})

######################
# Get File in folder #
######################
Get-ChildItem $ENV:USERPROFILE\Downloads | Select-Object Name > C:\temp\user_data_unusefull_downloadFolder.txt
$filecontent = Get-Content C:\temp\user_data_unusefull_downloadFolder.txt -Delimiter "/"

############
# TextBox1 #
############
$textbox1.Font = "Bahnschrift,12"
$textbox1.Size = New-Object System.Drawing.Size(580,300)
$textbox1.Location = New-Object system.Drawing.size(20,55)
$textbox1.ScrollBars = "Vertical"
$textbox1.AppendText($filecontent)
$textbox1.AppendText("`n`n")
$textbox1.Multiline = $true
$textbox1.ReadOnly = $true
$textbox1.BorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle

###############
# SHOW RESULT #
###############
$form.Controls.Add($menuMain)
$form.Controls.Add($label1)
$form.Controls.Add($label2)
$form.Controls.Add($label3)
$form.Controls.Add($progressbar)
$form.Controls.Add($textbox1)
$form.Controls.Add($button1)    
$form.Controls.Add($button2)
$form.Add_Shown( { $form.Activate() } )
$form.ShowDialog()