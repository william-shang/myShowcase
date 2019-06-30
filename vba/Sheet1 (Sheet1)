
Private Sub CommandButton21_Click()
Dim i As Integer
Dim sTime As String
Dim eTime As String
Dim SOName As String


For i = 1 To 99
    If Cells(i, 2).Value = "Exterior Patrol" Then
        SOName = Cells(i, 6).Value
        sTime = Format(Cells(i, 8).Value, "Short Time")
        eTime = Format(Cells(i, 9).Value, "Short Time")
        
        ' & vbNewLine & for /n in VBA
        'Format(MyTime, "Short Time") for time formats
        
        UserForm1.TextBox_exteriorPatrol.Value = vbNewLine & "S/O " & SOName & " started exterior patrol at " & sTime & " hrs; " & vbNewLine & "Patrol completed at " & eTime & " hrs; " & vbNewLine & "Exterior check: All Clear" & vbNewLine & UserForm1.TextBox_exteriorPatrol.Value

    End If

Next i
UserForm1.Show

End Sub

Private Sub CommandButton22_Click()

'Worksheets("Sheet1").Range("C1:C5").Copy

ActiveSheet.Paste Destination:=Worksheets("Sheet1").Range("A1:A60")
Range("H1:I99").NumberFormat = "hh:mm ;@"

End Sub

Private Sub CommandButton23_Click()
UserForm_initW.Show

End Sub

Private Sub Worksheet_Activate()
UserForm_initW.Show

End Sub

Private Sub Worksheet_SelectionChange(ByVal Target As Range)

End Sub
