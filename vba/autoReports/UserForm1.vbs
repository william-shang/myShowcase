Private Sub TextBox1_Change()

End Sub

Private Sub CommandButton1_Click()
ThisWorkbook.Saved = True

Application.Quit

End Sub

Private Sub UserForm_Activate()
   'Name of the frame
   With Me.TextBox_exteriorPatrol
        'This will create a vertical scrollbar
        .ScrollBars = fmScrollBarsVertical
        
        'Change the values of 2 as Per your requirements
        '.ScrollHeight = .InsideHeight * 2
        '.ScrollWidth = .InsideWidth * 9
    End With
End Sub
Private Sub TextBox_exteriorPatrol_Change()

End Sub
