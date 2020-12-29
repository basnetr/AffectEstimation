VERSION 5.00
Begin VB.Form frmMain 
   Caption         =   "Form1"
   ClientHeight    =   1335
   ClientLeft      =   60
   ClientTop       =   405
   ClientWidth     =   8910
   LinkTopic       =   "Form1"
   ScaleHeight     =   1335
   ScaleWidth      =   8910
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtVideoLoc 
      Height          =   285
      Left            =   1440
      TabIndex        =   5
      Text            =   "D:\LinuxCaffeCode\CaffeRegressionSEMAINE2\b_VideoWork\ExtractedVideoFrames"
      Top             =   480
      Width           =   7335
   End
   Begin VB.TextBox txtAudioLoc 
      Height          =   285
      Left            =   1440
      TabIndex        =   3
      Text            =   "D:\LinuxCaffeCode\CaffeRegressionSEMAINE2\a_AudioWork\ExtractedAudioSegments"
      Top             =   120
      Width           =   7335
   End
   Begin VB.CommandButton cmdGenerateMatchedFiles 
      Caption         =   "Generate _Original / _Audio_Edited / _Audio / _Video / _VideoInvalid"
      Height          =   375
      Left            =   3000
      TabIndex        =   2
      Top             =   840
      Width           =   5775
   End
   Begin VB.TextBox txtVideoNum 
      Height          =   285
      Left            =   2040
      TabIndex        =   0
      Text            =   "31"
      Top             =   840
      Width           =   855
   End
   Begin VB.Label Label3 
      Caption         =   "Video Location:"
      Height          =   375
      Left            =   120
      TabIndex        =   6
      Top             =   480
      Width           =   1215
   End
   Begin VB.Label Label2 
      Caption         =   "Audio Location:"
      Height          =   375
      Left            =   120
      TabIndex        =   4
      Top             =   120
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "Video/Audio Number:"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   840
      Width           =   1695
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdGenerateMatchedFiles_Click()
Dim tLineAudio As String
Dim tLieVideo As String
    Open CStr(txtAudioLoc.Text) & "\List_P" & Trim(txtVideoNum.Text) & ".txt" For Input As #100
    Open App.Path & "/List_" & Trim(txtVideoNum.Text) & "_Audio_Edited.txt" For Output As #200
    Open App.Path & "/List_P" & Trim(txtVideoNum.Text) & "_Audio_Backup.txt" For Output As #300
        Do While Not EOF(100)
            Input #100, tline
            Print #300, tline
            Print #200, Replace(tline, Chr(10), Chr(13) & Chr(10))
        Loop
    Close #100
    Close #200
    Close #300
    
    Open App.Path & "/List_" & Trim(txtVideoNum.Text) & "_Audio_Edited.txt" For Input As #1
    Open App.Path & "/List_" & Trim(txtVideoNum.Text) & "_Video.txt" For Output As #2
    Open App.Path & "/List_" & Trim(txtVideoNum.Text) & "_Audio.txt" For Output As #3
    Open App.Path & "/List_" & Trim(txtVideoNum.Text) & "_VideoInvalid.txt" For Output As #4
    
    Do While Not EOF(1)
    
        Input #1, tLineAudio 'Audio/P29/Audio11520.mat 0.0997 -0.3349
    If Trim(tLineAudio) <> "" Then
        tLineVideo = Replace(tLineAudio, "Audio", "Frame")
        tLineVideo = Replace(tLineVideo, ".mat", ".jpg")
        
        Dim jpgArr
        jpgArr = Split(tLineVideo, " ")
        jpgLoc = CStr(jpgArr(0))
        jpgLocArr = Split(jpgLoc, "/")
        jpgName = CStr(jpgLocArr(1))
    
        If Dir(CStr(txtVideoLoc.Text) & "\" & jpgLoc, vbDirectory) = jpgName Then 'file exist
            Print #2, "Video/" & tLineVideo
            Print #3, "Audio/" & tLineAudio
        Else
            Print #4, "Video/" & tLineVideo
        End If
    End If
    Loop
               
    Close #4
    Close #3
    Close #2
    Close #1
    MsgBox "Done"
End Sub
