Function Update-ADUsers {

Import-Csv -Header First, Last, sam, Email, title, Pager, Phone, mobile, office ./import.csv | `

ForEach-Object {

$givenName = $_.'First'
$sn = $_.'Last'
$title = $_.title
$Office = $_.office
$Phone = $_.phone
$Pager = $_.pager
$Mobile = $_.mobile
$mail = $_.Email
}
