Private Sub Image1_Click()

End Sub

Private Sub CommandButton_genReport_Click()
Dim i As Integer
Dim sTime As String
Dim eTime As String
Dim SOName As String


For i = 1 To 99
    If Cells(i, 2).Value = "Exterior Patrol" Then
        If Cells(i, 10).Value >= 8 Then
            SOName = Cells(i, 6).Value
            sTime = Format(Cells(i, 8).Value, "Short Time")
            eTime = Format(Cells(i, 9).Value, "Short Time")
            
            ' & vbNewLine & for /n in VBA
            'Format(MyTime, "Short Time") for time formats
            
            UserForm1.TextBox_exteriorPatrol.Value = vbNewLine & "S/O " & SOName & " started exterior patrol at " & sTime & " hrs; " & vbNewLine & "Patrol completed at " & eTime & " hrs; " & vbNewLine & "Exterior check: All Clear" & vbNewLine & UserForm1.TextBox_exteriorPatrol.Value
    
        End If
    End If

Next i
UserForm1.Show

End Sub

Private Sub CommandButton_loadData_Click()
'Worksheets("Sheet1").Range("C1:C5").Copy
'Worksheets("Sheet1").Range("A1:N99").Select
'Worksheets("Sheet1").Range("A1:A99").PasteSpecial xlPasteValues
'ActiveSheet.PasteSpecial Format:="HTML", Link:=False, DisplayAsIcon:=False, NoHTMLFormatting:=True
'ActiveSheet.Paste Destination:=Worksheets("Sheet1").Range("A1:A99")
'ActiveSheet.PasteSpecial Link:=False, DataType:=wdPasteText
'Worksheets("Sheet1").Range("A1:N99").PasteSpecial Operation:=xlPasteAllUsingSourceTheme
'Format:="HTML", Link:=False, DisplayAsIcon:=False, NoHTMLFormatting:=True

'Call paste1
'Cells.Select
Range("A1:N99").Select
ActiveSheet.PasteSpecial Format:="HTML", Link:=False, DisplayAsIcon:=False, NoHTMLFormatting:=True
'ActiveSheet.Paste Destination:=Worksheets("Sheet1").Range("A1:Z333")
Range("H1:I99").NumberFormat = "hh:mm ;@"

End Sub

Private Sub CommandButton1_Click()
Range("A5:Z999").Select
ActiveSheet.PasteSpecial Format:="HTML", Link:=False, DisplayAsIcon:=False, NoHTMLFormatting:=True
'ActiveSheet.Paste Destination:=Worksheets("Sheet1").Range("A1:Z333")


End Sub

Private Sub CommandButton2_Click()
'Dim months(11) As String
'months(0) = "Jan"
'months(1) = "Feb"
'months(2) = "Mar"
'months(3) = "Apr"
'months(4) = "May"
'months(5) = "Jun"
'months(6) = "Jul"
'months(7) = "Aug"
'months(8) = "Sep"
'months(9) = "Oct"
'months(10) = "Nov"
'months(11) = "Dec"

'Dim nowMonth As Integer
'nowMonth = Month(Now)

'Dim nowDate As Integer
'nowDate = Format$(Now(), "Short Date")

'Cells(2, 1).Value = months(nowMonth) & " " & nowDate & Year(Now)
Cells(2, 2).Value = Cells(14, 2).Value
Cells(2, 3).Value = Cells(23, 25).Value
Cells(2, 4).Value = Cells(16, 5).Value
Cells(2, 5).Value = "TELUS"
Cells(2, 6).Value = Format$(Now(), "Short Time")

Range("F2:H2").NumberFormat = "hh:mm ;@"

End Sub

Private Sub Label2_Click()

End Sub

Private Sub Label3_Click()

End Sub

Private Sub Label4_Click()

End Sub

Private Sub Label5_Click()

End Sub

Private Sub TextBox1_Change()

End Sub

Private Sub UserForm_Click()

End Sub

Private Sub UserForm_Initialize()
TextBox1.Value = "https://paladin.staffr.ca/"


End Sub
