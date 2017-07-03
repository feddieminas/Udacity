Attribute VB_Name = "modTeam"
Option Explicit
Option Base 1

Sub MyTeamTable()
Application.ScreenUpdating = False

Dim arr(1 To 76, 1 To 25) As Variant

Dim WB As Workbook
Set WB = ThisWorkbook
Dim SWS As Worksheet, DWS As Worksheet
Set SWS = WB.Worksheets("I1")
Set DWS = WB.Worksheets("Team")

Dim Team As String, HA As String
Dim dr As Integer, sr As Integer, Points As Integer, j As Integer, i As Integer

For dr = 5 To 80 Step 38
If DWS.Range("A" & dr).Value = "" Then Exit For

Team = DWS.Range("A" & dr).Value

For i = 0 To 37
For j = 1 To 25
arr(dr - 4 + i, j) = 0
Next j
Next i

i = 0
For sr = 2 To 381
If SWS.Range("C" & sr).Value = Team Xor SWS.Range("D" & sr).Value = Team Then
HA = IIf(SWS.Range("C" & sr).Value = Team, "H", "A")
arr(dr - 4 + i, 2) = HA

Select Case HA
Case "H"
Points = IIf(SWS.Range("G" & sr).Value = "H", 3, IIf(SWS.Range("G" & sr).Value = "A", 0, 1))
arr(dr - 4 + i, 4) = SWS.Range("E" & sr).Value 'GF
arr(dr - 4 + i, 5) = SWS.Range("F" & sr).Value 'GA
arr(dr - 4 + i, 6) = SWS.Range("K" & sr).Value 'S
arr(dr - 4 + i, 7) = SWS.Range("M" & sr).Value 'ST
arr(dr - 4 + i, 8) = SWS.Range("Q" & sr).Value 'C
arr(dr - 4 + i, 9) = SWS.Range("O" & sr).Value 'F
arr(dr - 4 + i, 10) = SWS.Range("S" & sr).Value 'Y
arr(dr - 4 + i, 11) = CDbl(SWS.Range("W" & sr).Value) 'B365W
arr(dr - 4 + i, 12) = CDbl(SWS.Range("X" & sr).Value) 'B365D
arr(dr - 4 + i, 13) = CDbl(SWS.Range("Y" & sr).Value) 'B365D
arr(dr - 4 + i, 14) = CDbl(SWS.Range("Z" & sr).Value) 'BWW
arr(dr - 4 + i, 15) = CDbl(SWS.Range("AA" & sr).Value) 'BWD
arr(dr - 4 + i, 16) = CDbl(SWS.Range("AB" & sr).Value) 'BWL
arr(dr - 4 + i, 17) = CDbl(SWS.Range("AF" & sr).Value) 'LBW
arr(dr - 4 + i, 18) = CDbl(SWS.Range("AG" & sr).Value) 'LBD
arr(dr - 4 + i, 19) = CDbl(SWS.Range("AH" & sr).Value) 'LBL
arr(dr - 4 + i, 20) = CDbl(SWS.Range("AI" & sr).Value) 'PSW
arr(dr - 4 + i, 21) = CDbl(SWS.Range("AJ" & sr).Value) 'PSD
arr(dr - 4 + i, 22) = CDbl(SWS.Range("AK" & sr).Value) 'PSL
arr(dr - 4 + i, 23) = CDbl(SWS.Range("AL" & sr).Value) 'WHW
arr(dr - 4 + i, 24) = CDbl(SWS.Range("AM" & sr).Value) 'WHD
arr(dr - 4 + i, 25) = CDbl(SWS.Range("AN" & sr).Value) 'WHL

Case "A"
Points = IIf(SWS.Range("G" & sr).Value = "A", 3, IIf(SWS.Range("G" & sr).Value = "H", 0, 1))
arr(dr - 4 + i, 4) = SWS.Range("F" & sr).Value 'GF
arr(dr - 4 + i, 5) = SWS.Range("E" & sr).Value 'GA
arr(dr - 4 + i, 6) = SWS.Range("L" & sr).Value 'S
arr(dr - 4 + i, 7) = SWS.Range("N" & sr).Value 'ST
arr(dr - 4 + i, 8) = SWS.Range("R" & sr).Value 'C
arr(dr - 4 + i, 9) = SWS.Range("P" & sr).Value 'F
arr(dr - 4 + i, 10) = SWS.Range("T" & sr).Value 'Y
arr(dr - 4 + i, 11) = CDbl(SWS.Range("Y" & sr).Value) 'B365W
arr(dr - 4 + i, 12) = CDbl(SWS.Range("X" & sr).Value) 'B365D
arr(dr - 4 + i, 13) = CDbl(SWS.Range("W" & sr).Value) 'B365D
arr(dr - 4 + i, 14) = CDbl(SWS.Range("AB" & sr).Value) 'BWW
arr(dr - 4 + i, 15) = CDbl(SWS.Range("AA" & sr).Value) 'BWD
arr(dr - 4 + i, 16) = CDbl(SWS.Range("Z" & sr).Value) 'BWL
arr(dr - 4 + i, 17) = CDbl(SWS.Range("AH" & sr).Value) 'LBW
arr(dr - 4 + i, 18) = CDbl(SWS.Range("AG" & sr).Value) 'LBD
arr(dr - 4 + i, 19) = CDbl(SWS.Range("AF" & sr).Value) 'LBL
arr(dr - 4 + i, 20) = CDbl(SWS.Range("AK" & sr).Value) 'PSW
arr(dr - 4 + i, 21) = CDbl(SWS.Range("AJ" & sr).Value) 'PSD
arr(dr - 4 + i, 22) = CDbl(SWS.Range("AI" & sr).Value) 'PSL
arr(dr - 4 + i, 23) = CDbl(SWS.Range("AN" & sr).Value) 'WHW
arr(dr - 4 + i, 24) = CDbl(SWS.Range("AM" & sr).Value) 'WHD
arr(dr - 4 + i, 25) = CDbl(SWS.Range("AL" & sr).Value) 'WHL
Case Else
End Select

arr(dr - 4 + i, 1) = Points 'Points
If Points = 3 Then
arr(dr - 4 + i, 3) = "W" 'W
ElseIf Points = 1 Then
arr(dr - 4 + i, 3) = "D" 'D
Else
arr(dr - 4 + i, 3) = "L" 'L
End If

i = i + 1
End If
Next sr

Next dr

DWS.Range("C4").Resize(1, UBound(arr, 2)).Value = Array("Points", "HA", "WDL", "GF", "GA", "S", "ST", "C", "F", "Y", "B365W", "B365D", "B365L", "BWW", "BWD", "BWL", "LBW", "LBD", "LBL", "PSW", "PSD", "PSL", "WHW", "WHD", "WHL")
DWS.Range("C5").Resize(UBound(arr, 1), UBound(arr, 2)).Value = arr

Erase arr
Set DWS = Nothing
Set SWS = Nothing
Set WB = Nothing

Application.ScreenUpdating = True
End Sub

Sub CopyPasteTTestData()
With ThisWorkbook

.Worksheets("t-test").Range("A5:A43").Value = .Worksheets("Team").Range("B4:B42").Value

.Worksheets("t-test").Range("B6:B43").Value = .Worksheets("Team").Range("F43:F80").Value
.Worksheets("t-test").Range("C6:C43").Value = .Worksheets("Team").Range("F5:F42").Value

End With
End Sub

Sub CopyPasteCHiGofData()
With ThisWorkbook

.Worksheets("Chi2GoF").Range("A5:D43").Value = .Worksheets("Team").Range("B4:E42").Value

Dim xlSort As XlSortOrder
xlSort = xlDescending

.Worksheets("Chi2GoF").Range("A5:D43").Sort Key1:=.Worksheets("Chi2GoF").Range("C5"), Order1:=xlSort, Header:=xlYes, _
            OrderCustom:=1, MatchCase:=False, Orientation:=xlTopToBottom, _
            DataOption1:=xlSortNormal

End With
End Sub

Sub CopyPasteChi2IndData()
With ThisWorkbook

.Worksheets("Chi2Ind").Range("A5:D43").Value = .Worksheets("Team").Range("B4:E42").Value

.Worksheets("Chi2Ind").Range("E5:E43").Value = .Worksheets("Team").Range("N4:N42").Value
.Worksheets("Chi2Ind").Range("F5:F43").Value = .Worksheets("Team").Range("Q4:Q42").Value
.Worksheets("Chi2Ind").Range("G5:G43").Value = .Worksheets("Team").Range("T4:T42").Value
.Worksheets("Chi2Ind").Range("H5:H43").Value = .Worksheets("Team").Range("W4:W42").Value
.Worksheets("Chi2Ind").Range("I5:I43").Value = .Worksheets("Team").Range("Z4:Z42").Value


Dim xlSort As XlSortOrder
xlSort = xlDescending

.Worksheets("Chi2Ind").Range("A5:I43").Sort Key1:=.Worksheets("Chi2Ind").Range("C5"), Order1:=xlSort, Header:=xlYes, _
            OrderCustom:=1, MatchCase:=False, Orientation:=xlTopToBottom, _
            DataOption1:=xlSortNormal

End With
End Sub
