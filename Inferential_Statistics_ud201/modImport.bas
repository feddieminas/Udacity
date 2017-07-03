Attribute VB_Name = "modImport"

Function MyTextFileQuery(MyDirSourceWb As String, MyDestWS As String) As Boolean
Dim connectionName As String
connectionName = "TEXT;" + MyDirSourceWb

On Error GoTo MyError:

With Worksheets(MyDestWS).QueryTables.Add(Connection:=connectionName, Destination:=Worksheets(MyDestWS).Range("A1"))
.Name = MyDirSourceWb
.FieldNames = True
.RowNumbers = False
.FillAdjacentFormulas = False
.PreserveFormatting = True
.RefreshOnFileOpen = False
.RefreshStyle = xlOverwriteCells
.SavePassword = False
.SaveData = True
.AdjustColumnWidth = True
.RefreshPeriod = 0
.TextFilePromptOnRefresh = False
.TextFilePlatform = 437
.TextFileDecimalSeparator = "." ' for anglosaxon this would be changed to "." otherwise ","
.TextFileThousandsSeparator = False ' ","
.TextFileStartRow = 1 ' you could change this if you wanted to import starting from a different row
.TextFileParseType = xlDelimited
.TextFileTextQualifier = xlTextQualifierNone  'xlTextQualifierSingleQuote, xlTextQualifierDoubleQuote, xlTextQualifierNone
'.TextFileColumnDataTypes = 1
.TextFileConsecutiveDelimiter = False
.TextFileTabDelimiter = False
.TextFileSemicolonDelimiter = False 'False typical european separator...then should be set to true
.TextFileCommaDelimiter = True ' thiss would be the normal anglosaxon comma separator, and would then be set to true
.TextFileSpaceDelimiter = False
'.TextFileOtherDelimiter = False '"-"
.Refresh BackgroundQuery:=False   'Default is false
End With
MyTextFileQuery = True
Exit Function

MyError:
MyTextFileQuery = False

End Function

Sub MyCSVImportQTallowed()
Dim MyQueryTable As QueryTable
Dim MyExample As String, SuccessfulResult As Boolean

Application.ScreenUpdating = False

MyExample = "http://football-data.co.uk/mmz4281/1314/I1.csv" 'file taken directly from the website
                                                             'Stored a copy of the file at gh for visualisation
ThisWorkbook.Worksheets("I1").Cells.Clear
SuccessfulResult = MyTextFileQuery(MyExample, "I1")

'you dont want to have ever querytables residing in your workbook if you can avoid it

If SuccessfulResult = True Then
For Each MyQueryTable In Worksheets("I1").QueryTables
MyQueryTable.Delete
Next
Else
Debug.Print "File has not been successfully imported" 'or MsgBox
End
End If

DeleteConnections

'''Kill MyExample

'Colour the header columns I would be taking into account in blue and white font

Dim rngcolor As Range, cell As Range
Set rngcolor = ThisWorkbook.Worksheets("I1").Range("C1:G1, K1:T1 , W1:AB1, AF1:AN1")

For Each cell In rngcolor
cell.Interior.Color = RGB(0, 176, 240)
cell.Font.Color = RGB(255, 255, 255)
Next cell

Set rngcolor = Nothing

Application.ScreenUpdating = True

End Sub

Sub DeleteConnections()
For Each cn In ThisWorkbook.Connections
cn.Delete
Next cn
End Sub

