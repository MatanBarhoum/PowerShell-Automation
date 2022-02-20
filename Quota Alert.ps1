### מערכת שרצה ברקע ומבררת בזמן נתון כמה שטח פנוי יש בדיסק. במידה והשטח הפנוי הוא מתחת להמלצה של מיקרוסופט למערכות הפעלה וינדוס 10 הוא שולח התרעת אוטלוק לאדם שאחראי
### עדיף לקבץ לקובץ (exe) למיטוב ביצועים

$users = Get-WmiObject -Class Win32_UserProfile | Select-Object -Property LocalPath
$diskQ = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'"
$Size = $diskQ.Size / 1GB
$Free = $diskQ.FreeSpace / 1GB
$Used = $size - $Free

while ($true){
if ($free -lt "20") {

##or

$outlook = New-Object -ComObject Outlook.Application

$email = $outlook.CreateItem(0)
$email.To = "מי מקבל את ההודעה מהמשתמשים?"
$email.Subject = "חריגת מקום פנוי בכונן זוהתה"
$email.Body = "                                                                                                                                                                                                                      לידיעתך, במחשב זה נותרו פחות מ-20 ג'יגה פנויים בכונן"

$email.Send()

Start-Sleep -Seconds 259200 #לך לישון ל3 ימים

}}
