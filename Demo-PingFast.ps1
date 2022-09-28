function Show-PingFast {

	Add-Type -AssemblyName System.Windows.Form

	[System.Windows.Forms.Application]::EnableVisualStyles()
	$formPingFastlyMyForm = New-Object 'System.Windows.Forms.Form'
	$buttonKillJob = New-Object 'System.Windows.Forms.Button'
	$labelRange1254 = New-Object 'System.Windows.Forms.Label'
	$textboxNetwork = New-Object 'System.Windows.Forms.TextBox'
	$datagridview1 = New-Object 'System.Windows.Forms.DataGridView'
	$buttonPingAll = New-Object 'System.Windows.Forms.Button'
	$buttonOK = New-Object 'System.Windows.Forms.Button'
	$pingTimer = New-Object 'System.Windows.Forms.Timer'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'

	$jobScript = {
	    param(
	        $Servers
	    )
		$pingAsync = foreach ($server in $Servers){
			$p = [Net.NetworkInformation.Ping]::New()
	        $asyn = $p.SendPingAsync($server,250)
	        $asyn | Add-Member -MemberType NoteProperty -Name Server -Value $server -PassThru
		}
		[System.Threading.Tasks.Task]::WaitAll($pingAsync)
	    $pingAsync | %{
	        $_ | 
	            Select-Object -Expand result |
	            Add-Member -MemberType NoteProperty -Name Server -Value $_.Server -PassThru
	    }
	}
	
	$formPingFastlyMyForm_Load={
	}
	
	$buttonPingAll_Click={
	    $this.Enabled = $false
	    $datagridview1.DataSource = $null
	    $t = $textboxNetwork.Text + '.{0}'
	    $servers = 1..254 | %{$t -f $_}
	    #$servers = 2..247 | %{"10.0.0.$_"}
	    $script:pingjob = Start-Job -Name PingStatus -ScriptBlock $jobScript -ArgumentList @(,$servers)
	    $pingTimer.Enabled = $true
	    $buttonKillJob.Visible = $true
	}
	
	$pingTimer_Tick={
	    $pingTimer.Enabled = $false
		if($pingjob.State -eq 'Completed'){
	        $results= Receive-Job $pingjob | 
	            Select-Object Server, Status, Address, RoundTripTime
	        $datagridview1.DataSource = ConvertTo-DataTable $results
	        Remove-Job $pingjob -Force
	        Remove-Variable -Name pingjob -Scope Script -Force
	        $buttonPingAll.Enabled = $true
	        $buttonKillJob.Visible = $false
	    }else{
	        $pingTimer.Enabled = $true
	    }
	}
	
	$datagridview1_RowPostPaint=[System.Windows.Forms.DataGridViewRowPostPaintEventHandler]{
	#Event Argument: $_ = [System.Windows.Forms.DataGridViewRowPostPaintEventArgs]
	    $bgcolor = if($datagridview1.Rows[$_.RowIndex].Cells['Status'].Value -eq 'Success'){
		    'LightGreen'
	    }else{
	        'Pink'
	    }
	    $datagridview1.Rows[$_.RowIndex].Cells | %{$_.Style.BackColor = $bgcolor }
	}
	
	#region Control Helper Functions
	function ConvertTo-DataTable
	{
		<#
			.SYNOPSIS
				Converts objects into a DataTable.
		
			.DESCRIPTION
				Converts objects into a DataTable, which are used for DataBinding.
		
			.PARAMETER  InputObject
				The input to convert into a DataTable.
		
			.PARAMETER  Table
				The DataTable you wish to load the input into.
		
			.PARAMETER RetainColumns
				This switch tells the function to keep the DataTable's existing columns.
			
			.PARAMETER FilterWMIProperties
				This switch removes WMI properties that start with an underline.
		
			.EXAMPLE
				$DataTable = ConvertTo-DataTable -InputObject (Get-Process)
		#>
		[OutputType([System.Data.DataTable])]
		param(
		[ValidateNotNull()]
		$InputObject, 
		[ValidateNotNull()]
		[System.Data.DataTable]$Table,
		[switch]$RetainColumns,
		[switch]$FilterWMIProperties)
		
		if($null -eq $Table)
		{
			$Table = New-Object System.Data.DataTable
		}
		
		if ($InputObject -is [System.Data.DataTable])
		{
			$Table = $InputObject
		}
		elseif ($InputObject -is [System.Data.DataSet] -and $InputObject.Tables.Count -gt 0)
		{
			$Table = $InputObject.Tables[0]
		}
		else
		{
			if (-not $RetainColumns -or $Table.Columns.Count -eq 0)
			{
				#Clear out the Table Contents
				$Table.Clear()
				
				if ($null -eq $InputObject) { return } #Empty Data
				
				$object = $null
				#find the first non null value
				foreach ($item in $InputObject)
				{
					if ($null -ne $item)
					{
						$object = $item
						break
					}
				}
				
				if ($null -eq $object) { return } #All null then empty
				
				#Get all the properties in order to create the columns
				foreach ($prop in $object.PSObject.Get_Properties())
				{
					if (-not $FilterWMIProperties -or -not $prop.Name.StartsWith('__')) #filter out WMI properties
					{
						#Get the type from the Definition string
						$type = $null
						
						if ($null -ne $prop.Value)
						{
							try { $type = $prop.Value.GetType() }
							catch { Out-Null }
						}
						
						if ($null -ne $type) # -and [System.Type]::GetTypeCode($type) -ne 'Object')
						{
							[void]$table.Columns.Add($prop.Name, $type)
						}
						else #Type info not found
						{
							[void]$table.Columns.Add($prop.Name)
						}
					}
				}
				
				if ($object -is [System.Data.DataRow])
				{
					foreach ($item in $InputObject)
					{
						$Table.Rows.Add($item)
					}
					return @( ,$Table)
				}
			}
			else
			{
				$Table.Rows.Clear()
			}
			
			foreach ($item in $InputObject)
			{
				$row = $table.NewRow()
				
				if ($item)
				{
					foreach ($prop in $item.PSObject.Get_Properties())
					{
						if ($table.Columns.Contains($prop.Name))
						{
							$row.Item($prop.Name) = $prop.Value
						}
					}
				}
				[void]$table.Rows.Add($row)
			}
		}
		
		return @(,$Table)	
	}
	#endregion
	
	$buttonKillJob_Click={
		Get-Job | Remove-Job -Force
	    $buttonPingAll.Enabled = $true
	    $buttonKillJob.Visible = $false
	}
	
	$Form_StateCorrection_Load =	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$formPingFastlyMyForm.WindowState = $InitialFormWindowState
	}
	
	$Form_Cleanup_FormClosed = {
		#Remove all event handlers from the controls
		try{
			$buttonKillJob.remove_Click($buttonKillJob_Click)
			$datagridview1.remove_RowPostPaint($datagridview1_RowPostPaint)
			$buttonPingAll.remove_Click($buttonPingAll_Click)
			$formPingFastlyMyForm.remove_Load($formPingFastlyMyForm_Load)
			$pingTimer.remove_Tick($pingTimer_Tick)
			$formPingFastlyMyForm.remove_Load($Form_StateCorrection_Load)
			$formPingFastlyMyForm.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch {}
	}

	$formPingFastlyMyForm.SuspendLayout()
	$datagridview1.BeginInit()
	$formPingFastlyMyForm.Controls.Add($buttonKillJob)
	$formPingFastlyMyForm.Controls.Add($labelRange1254)
	$formPingFastlyMyForm.Controls.Add($textboxNetwork)
	$formPingFastlyMyForm.Controls.Add($datagridview1)
	$formPingFastlyMyForm.Controls.Add($buttonPingAll)
	$formPingFastlyMyForm.Controls.Add($buttonOK)
	$formPingFastlyMyForm.AutoScaleDimensions = '6, 13'
	$formPingFastlyMyForm.AutoScaleMode = 'Font'
	$formPingFastlyMyForm.BackColor = '255, 224, 192'
	$formPingFastlyMyForm.CancelButton = $buttonOK
	$formPingFastlyMyForm.ClientSize = '422, 415'
	$formPingFastlyMyForm.FormBorderStyle = 'FixedDialog'
	$formPingFastlyMyForm.Margin = '4, 4, 4, 4'
	$formPingFastlyMyForm.MaximizeBox = $False
	$formPingFastlyMyForm.MinimizeBox = $False
	$formPingFastlyMyForm.Name = 'formPingFastlyMyForm'
	$formPingFastlyMyForm.StartPosition = 'CenterScreen'
	$formPingFastlyMyForm.Text = 'Ping Fastly MyForm'
	$formPingFastlyMyForm.add_Load($formPingFastlyMyForm_Load)

	# buttonKillJob
	$buttonKillJob.Location = '205, 10'
	$buttonKillJob.Name = 'buttonKillJob'
	$buttonKillJob.Size = '75, 23'
	$buttonKillJob.TabIndex = 4
	$buttonKillJob.Text = 'Kill Job'
	$buttonKillJob.UseCompatibleTextRendering = $True
	$buttonKillJob.UseVisualStyleBackColor = $True
	$buttonKillJob.Visible = $False
	$buttonKillJob.add_Click($buttonKillJob_Click)
	
	# labelRange1254
	$labelRange1254.AutoSize = $True
	$labelRange1254.Font = 'Microsoft Sans Serif, 7.8pt, style=Bold'
	$labelRange1254.Location = '66, 13'
	$labelRange1254.Name = 'labelRange1254'
	$labelRange1254.Size = '71, 17'
	$labelRange1254.TabIndex = 3
	$labelRange1254.Text = 'Range: 1-254'
	$labelRange1254.UseCompatibleTextRendering = $True

	# textboxNetwork
	$textboxNetwork.Location = '10, 10'
	$textboxNetwork.Margin = '2, 2, 2, 2'
	$textboxNetwork.Name = 'textboxNetwork'
	$textboxNetwork.Size = '51, 20'
	$textboxNetwork.TabIndex = 1
	$textboxNetwork.Text = '10.0.0'
	
	# datagridview1
	$datagridview1.AutoSizeColumnsMode = 'AllCells'
	$datagridview1.BackgroundColor = '224, 224, 224'
	$datagridview1.ColumnHeadersHeightSizeMode = 'AutoSize'
	$datagridview1.Location = '10, 39'
	$datagridview1.Name = 'datagridview1'
	$datagridview1.RowTemplate.Height = 24
	$datagridview1.Size = '400, 325'
	$datagridview1.TabIndex = 2
	$datagridview1.add_RowPostPaint($datagridview1_RowPostPaint)

	# buttonPingAll
	$buttonPingAll.BackColor = 'Green'
	$buttonPingAll.Font = 'Microsoft Sans Serif, 7.8pt, style=Bold'
	$buttonPingAll.ForeColor = 'White'
	$buttonPingAll.Location = '334, 10'
	$buttonPingAll.Name = 'buttonPingAll'
	$buttonPingAll.Size = '75, 23'
	$buttonPingAll.TabIndex = 1
	$buttonPingAll.Text = 'Ping All'
	$buttonPingAll.UseCompatibleTextRendering = $True
	$buttonPingAll.UseVisualStyleBackColor = $False
	$buttonPingAll.add_Click($buttonPingAll_Click)

	# buttonOK
	$buttonOK.Anchor = 'Bottom, Right'
	$buttonOK.DialogResult = 'Ignore'
	$buttonOK.Location = '334, 380'
	$buttonOK.Name = 'buttonOK'
	$buttonOK.Size = '75, 23'
	$buttonOK.TabIndex = 0
	$buttonOK.Text = '&OK'
	$buttonOK.UseCompatibleTextRendering = $True
	$buttonOK.UseVisualStyleBackColor = $True

	# pingTimer
	$pingTimer.Interval = 1000
	$pingTimer.add_Tick($pingTimer_Tick)
	$datagridview1.EndInit()
	$formPingFastlyMyForm.ResumeLayout()

	#Save the initial state of the form
	$InitialFormWindowState = $formPingFastlyMyForm.WindowState
	
	#Init the OnLoad event to correct the initial state of the form
	$formPingFastlyMyForm.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$formPingFastlyMyForm.add_FormClosed($Form_Cleanup_FormClosed)
	#Show the Form
	return $formPingFastlyMyForm.ShowDialog()

} #End Function

Show-PingFast
