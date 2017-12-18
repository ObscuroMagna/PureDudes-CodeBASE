[CmdletBinding()]
Param([Parameter(Mandatory=$True,Position=1)][string]$targetUser,[Parameter(Mandatory=$True,Position=2)][string]$targetDB)

Try
    {
     enable-mailbox -identity $targetUser -alias $targetUser -database $targetDB -ErrorAction "Stop"
     Set-CASMailbox $targetUser -ImapEnabled $False
     Set-CASMailbox $targetUser -ActiveSyncEnabled $False
     Set-CASMailbox $targetUser -PopEnabled $False
    }
Catch [System.Management.Automation.RemoteException]
    {
     write-host "Error in trying to create mailbox."
     $_.exception.getType().fullname
    break
    }

send-mailmessage -to "Help-Desk <help-desk@creditsights.com>","SysAdmins <systemsnotifications@creditsights.com>" `
-subject "Mailbox created for $targetUser" `
-smtpserver "mail.creditsights.net" `
-from "New Mailbox Creation <help-desk@creditsights.com>" `
-body "Mailbox has been created for $targetUser in databse $targetDB.  This message has been generated by script."

