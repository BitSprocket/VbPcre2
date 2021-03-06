VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cPcre2Matches"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

' Copyright (c) 2017 Jason Peter Brown <jason@bitspaces.com>
'
' MIT License
'
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
'
' The above copyright notice and this permission notice shall be included in all
' copies or substantial portions of the Software.
'
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
' SOFTWARE.

Private mo_Matches As VBA.Collection
Private m_AppendedText As String

Public Property Get Count() As Long
   Count = mo_Matches.Count
End Property

Public Property Get Item(ByVal p_ZeroBasedIndex As Long) As cPcre2Match
Attribute Item.VB_UserMemId = 0
   Set Item = mo_Matches.Item(p_ZeroBasedIndex + 1)
End Property

Public Function Enumerator() As IUnknown
Attribute Enumerator.VB_UserMemId = -4
Attribute Enumerator.VB_MemberFlags = "40"
   Set Enumerator = mo_Matches.[_NewEnum]
End Function

Public Property Get Text() As String
   Dim lo_Match As cPcre2Match
   
   For Each lo_Match In mo_Matches
      Text = Text & lo_Match.SearchedText
   Next lo_Match
   
   If LenB(m_AppendedText) > 0 Then
      Text = Text & m_AppendedText
   End If
End Property

Friend Sub AppendText(ByVal p_Text As String)
   m_AppendedText = m_AppendedText & p_Text
End Sub

Friend Sub Add(ByVal p_TextToSearch As String, pa_OvectorArray() As Long, ByVal p_MatchCount As Long, ByVal p_MatchOffset As Long)
   Dim lo_Match As cPcre2Match
   
   Set lo_Match = New cPcre2Match
   
   lo_Match.Init p_TextToSearch, pa_OvectorArray, p_MatchCount, p_MatchOffset
   
   mo_Matches.Add lo_Match
End Sub

Private Sub Class_Initialize()
   Set mo_Matches = New VBA.Collection
End Sub
