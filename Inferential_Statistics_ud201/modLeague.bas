Attribute VB_Name = "modLeague"
Option Explicit
Option Base 1

Sub MyLeagueTable()
Application.ScreenUpdating = False

Dim arr(1 To 20, 1 To 26) As Variant

Dim WB As Workbook
Set WB = ThisWorkbook
Dim SWS As Worksheet, DWS As Worksheet
Set SWS = WB.Worksheets("I1")
Set DWS = WB.Worksheets("League")

Dim Team As String, HA As String
Dim dr As Integer, sr As Integer, Points As Integer, j As Integer
dr = 2
Do
Team = DWS.Range("B" & dr).Value

For j = 1 To 26
arr(dr - 1, j) = 0
Next j

For sr = 2 To 381
If SWS.Range("C" & sr).Value = Team Xor SWS.Range("D" & sr).Value = Team Then
HA = IIf(SWS.Range("C" & sr).Value = Team, "H", "A")

Select Case HA
Case "H"
Points = IIf(SWS.Range("G" & sr).Value = "H", 3, IIf(SWS.Range("G" & sr).Value = "A", 0, 1))
arr(dr - 1, 5) = arr(dr - 1, 5) + SWS.Range("E" & sr).Value 'GF
arr(dr - 1, 6) = arr(dr - 1, 6) + SWS.Range("F" & sr).Value 'GA
arr(dr - 1, 7) = arr(dr - 1, 7) + SWS.Range("K" & sr).Value  'S
arr(dr - 1, 8) = arr(dr - 1, 8) + SWS.Range("M" & sr).Value  'ST
arr(dr - 1, 9) = arr(dr - 1, 9) + SWS.Range("Q" & sr).Value  'C
arr(dr - 1, 10) = arr(dr - 1, 10) + SWS.Range("O" & sr).Value  'F
arr(dr - 1, 11) = arr(dr - 1, 11) + SWS.Range("S" & sr).Value 'Y
arr(dr - 1, 12) = CDbl(arr(dr - 1, 12) + SWS.Range("W" & sr).Value) 'B365W
arr(dr - 1, 13) = CDbl(arr(dr - 1, 13) + SWS.Range("X" & sr).Value) 'B365D
arr(dr - 1, 14) = CDbl(arr(dr - 1, 14) + SWS.Range("Y" & sr).Value) 'B365D
arr(dr - 1, 15) = CDbl(arr(dr - 1, 15) + SWS.Range("Z" & sr).Value) 'BWW
arr(dr - 1, 16) = CDbl(arr(dr - 1, 16) + SWS.Range("AA" & sr).Value) 'BWD
arr(dr - 1, 17) = CDbl(arr(dr - 1, 17) + SWS.Range("AB" & sr).Value) 'BWL
arr(dr - 1, 18) = CDbl(arr(dr - 1, 18) + SWS.Range("AF" & sr).Value) 'LBW
arr(dr - 1, 19) = CDbl(arr(dr - 1, 19) + SWS.Range("AG" & sr).Value) 'LBD
arr(dr - 1, 20) = CDbl(arr(dr - 1, 20) + SWS.Range("AH" & sr).Value) 'LBL
arr(dr - 1, 21) = CDbl(arr(dr - 1, 21) + SWS.Range("AI" & sr).Value) 'PSW
arr(dr - 1, 22) = CDbl(arr(dr - 1, 22) + SWS.Range("AJ" & sr).Value) 'PSD
arr(dr - 1, 23) = CDbl(arr(dr - 1, 23) + SWS.Range("AK" & sr).Value) 'PSL
arr(dr - 1, 24) = CDbl(arr(dr - 1, 24) + SWS.Range("AL" & sr).Value) 'WHW
arr(dr - 1, 25) = CDbl(arr(dr - 1, 25) + SWS.Range("AM" & sr).Value) 'WHD
arr(dr - 1, 26) = CDbl(arr(dr - 1, 26) + SWS.Range("AN" & sr).Value) 'WHL

Case "A"
Points = IIf(SWS.Range("G" & sr).Value = "A", 3, IIf(SWS.Range("G" & sr).Value = "H", 0, 1))
arr(dr - 1, 5) = arr(dr - 1, 5) + SWS.Range("F" & sr).Value 'GF
arr(dr - 1, 6) = arr(dr - 1, 6) + SWS.Range("E" & sr).Value 'GA
arr(dr - 1, 7) = arr(dr - 1, 7) + SWS.Range("L" & sr).Value  'S
arr(dr - 1, 8) = arr(dr - 1, 8) + SWS.Range("N" & sr).Value  'ST
arr(dr - 1, 9) = arr(dr - 1, 9) + SWS.Range("R" & sr).Value  'C
arr(dr - 1, 10) = arr(dr - 1, 10) + SWS.Range("P" & sr).Value  'F
arr(dr - 1, 11) = arr(dr - 1, 11) + SWS.Range("T" & sr).Value 'Y
arr(dr - 1, 12) = CDbl(arr(dr - 1, 12) + SWS.Range("Y" & sr).Value) 'B365W
arr(dr - 1, 13) = CDbl(arr(dr - 1, 13) + SWS.Range("X" & sr).Value) 'B365D
arr(dr - 1, 14) = CDbl(arr(dr - 1, 14) + SWS.Range("W" & sr).Value) 'B365D
arr(dr - 1, 15) = CDbl(arr(dr - 1, 15) + SWS.Range("AB" & sr).Value) 'BWW
arr(dr - 1, 16) = CDbl(arr(dr - 1, 16) + SWS.Range("AA" & sr).Value) 'BWD
arr(dr - 1, 17) = CDbl(arr(dr - 1, 17) + SWS.Range("Z" & sr).Value) 'BWL
arr(dr - 1, 18) = CDbl(arr(dr - 1, 18) + SWS.Range("AH" & sr).Value) 'LBW
arr(dr - 1, 19) = CDbl(arr(dr - 1, 19) + SWS.Range("AG" & sr).Value) 'LBD
arr(dr - 1, 20) = CDbl(arr(dr - 1, 20) + SWS.Range("AF" & sr).Value) 'LBL
arr(dr - 1, 21) = CDbl(arr(dr - 1, 21) + SWS.Range("AK" & sr).Value) 'PSW
arr(dr - 1, 22) = CDbl(arr(dr - 1, 22) + SWS.Range("AJ" & sr).Value) 'PSD
arr(dr - 1, 23) = CDbl(arr(dr - 1, 23) + SWS.Range("AI" & sr).Value) 'PSL
arr(dr - 1, 24) = CDbl(arr(dr - 1, 24) + SWS.Range("AN" & sr).Value) 'WHW
arr(dr - 1, 25) = CDbl(arr(dr - 1, 25) + SWS.Range("AM" & sr).Value) 'WHD
arr(dr - 1, 26) = CDbl(arr(dr - 1, 26) + SWS.Range("AL" & sr).Value) 'WHL
Case Else
End Select

arr(dr - 1, 1) = arr(dr - 1, 1) + Points  'Points
If Points = 3 Then
arr(dr - 1, 2) = arr(dr - 1, 2) + 1 'W
ElseIf Points = 1 Then
arr(dr - 1, 3) = arr(dr - 1, 3) + 1 'D
Else
arr(dr - 1, 4) = arr(dr - 1, 4) + 1 'L
End If

End If
Next sr

For j = 12 To 26
arr(dr - 1, j) = CDbl(arr(dr - 1, j) / 38)
Next j

dr = dr + 1
Loop Until DWS.Range("B" & dr).Value = ""

DWS.Range("C1").Resize(1, UBound(arr, 2)).Value = Array("Points", "W", "D", "L", "GF", "GA", "S", "ST", "C", "F", "Y", "B365W", "B365D", "B365L", "BWW", "BWD", "BWL", "LBW", "LBD", "LBL", "PSW", "PSD", "PSL", "WHW", "WHD", "WHL")
DWS.Range("C2").Resize(UBound(arr, 1), UBound(arr, 2)).Value = arr

Erase arr
Set DWS = Nothing
Set SWS = Nothing
Set WB = Nothing

Application.ScreenUpdating = True
End Sub


