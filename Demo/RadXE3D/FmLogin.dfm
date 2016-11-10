object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  Caption = 'Login Form'
  ClientHeight = 269
  ClientWidth = 426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 426
    Height = 269
    ActivePage = tsSettings
    Align = alClient
    TabOrder = 0
    object tsSettings: TTabSheet
      Caption = 'tsSettings'
      ImageIndex = 1
      object lblFileName: TLabel
        Left = 3
        Top = 50
        Width = 43
        Height = 13
        Caption = 'FileName'
      end
      object lblLogLevel: TLabel
        Left = 3
        Top = 4
        Width = 42
        Height = 13
        Caption = 'LogLevel'
      end
      object lblFileExt: TLabel
        Left = 3
        Top = 97
        Width = 32
        Height = 13
        Caption = 'FileExt'
      end
      object lblFormatDateStr: TLabel
        Left = 3
        Top = 142
        Width = 71
        Height = 13
        Caption = 'FormatDateStr'
      end
      object lblFileDir: TLabel
        Left = 1
        Top = 188
        Width = 29
        Height = 13
        Caption = 'FileDir'
      end
      object lblFormatDateTimeToLog: TLabel
        Left = 192
        Top = 96
        Width = 108
        Height = 13
        Caption = 'FormatDateTimeToLog'
      end
      object edtFileName: TEdit
        Left = 3
        Top = 70
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object cmbLogLevel: TComboBox
        Left = 2
        Top = 23
        Width = 145
        Height = 21
        TabOrder = 1
        Text = 'cmbLogLevel'
        Items.Strings = (
          'INFO'
          'ERROR'
          'TRACE'
          'ALL')
      end
      object cbActive: TCheckBox
        Left = 192
        Top = 3
        Width = 144
        Height = 17
        Caption = 'Active'
        TabOrder = 2
      end
      object cbKeepOpened: TCheckBox
        Left = 192
        Top = 49
        Width = 144
        Height = 17
        Caption = 'KeepOpened'
        TabOrder = 3
      end
      object cbAddDateTimeToLog: TCheckBox
        Left = 192
        Top = 72
        Width = 144
        Height = 17
        Caption = 'AddDateTimeToLog'
        TabOrder = 4
      end
      object edtFileExt: TEdit
        Left = 2
        Top = 115
        Width = 121
        Height = 21
        TabOrder = 5
      end
      object edtFormatDateStr: TEdit
        Left = 0
        Top = 161
        Width = 121
        Height = 21
        TabOrder = 6
      end
      object btnSelectFileDir: TButton
        Left = 342
        Top = 205
        Width = 73
        Height = 25
        Action = aSelectFileDir
        TabOrder = 7
      end
      object edtFileDir: TEdit
        Left = 1
        Top = 207
        Width = 335
        Height = 21
        TabOrder = 8
        Text = '.\Log'
      end
      object edtFormatDateTimeToLog: TEdit
        Left = 192
        Top = 115
        Width = 121
        Height = 21
        TabOrder = 9
      end
      object cbAddMessageTypeToLog: TCheckBox
        Left = 192
        Top = 26
        Width = 147
        Height = 17
        Caption = 'AddMessageTypeToLog'
        TabOrder = 10
      end
    end
    object tsWriteString: TTabSheet
      Caption = 'tsWriteString'
      object grpWriteStringds: TGroupBox
        Left = 0
        Top = 73
        Width = 418
        Height = 168
        Align = alClient
        Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1074' '#1083#1086#1075
        TabOrder = 0
        object mmWriteStrings: TMemo
          Left = 2
          Top = 15
          Width = 414
          Height = 126
          Align = alClient
          Lines.Strings = (
            'mmWriteStrings')
          TabOrder = 0
        end
        object Button1: TButton
          Left = 2
          Top = 141
          Width = 414
          Height = 25
          Action = aWriteStrings
          Align = alBottom
          TabOrder = 1
        end
      end
      object grpWriteString: TGroupBox
        Left = 0
        Top = 0
        Width = 418
        Height = 73
        Align = alTop
        Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1074' '#1083#1086#1075' '#1089#1090#1088#1086#1082#1091
        TabOrder = 1
        object edtLogText: TEdit
          Left = 2
          Top = 20
          Width = 414
          Height = 21
          Align = alBottom
          TabOrder = 0
          Text = 'edtLogText'
        end
        object btnWriteToLog: TButton
          Left = 2
          Top = 41
          Width = 414
          Height = 30
          Action = aWriteToLog
          Align = alBottom
          TabOrder = 1
        end
      end
    end
    object tsWriteFrom: TTabSheet
      Caption = 'tsWriteFrom'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblWriteFromFile: TLabel
        Left = 3
        Top = 3
        Width = 66
        Height = 13
        Caption = 'WriteFromFile'
      end
      object lblWriteFromSream: TLabel
        Left = 1
        Top = 50
        Width = 84
        Height = 13
        Caption = 'WriteFromStream'
      end
      object edtWriteFromFile: TEdit
        Left = 2
        Top = 19
        Width = 330
        Height = 21
        TabOrder = 0
      end
      object edtWriteFromSream: TEdit
        Left = 2
        Top = 75
        Width = 296
        Height = 21
        TabOrder = 1
      end
      object btnSelectFileForWrite: TButton
        Left = 340
        Top = 17
        Width = 72
        Height = 25
        Action = aSelectFile
        TabOrder = 2
      end
      object btnSelectFileForStream: TButton
        Left = 304
        Top = 73
        Width = 111
        Height = 25
        Action = aSelectFileForStream
        TabOrder = 3
      end
      object btnWriteFile: TButton
        Left = 340
        Top = 45
        Width = 75
        Height = 25
        Action = aWriteFile
        TabOrder = 4
      end
      object btnWriteStream: TButton
        Left = 304
        Top = 101
        Width = 111
        Height = 25
        Action = aWriteStream
        TabOrder = 5
      end
    end
  end
  object LogFile: TtLogFile
    Active = False
    KeepOpened = False
    AddDateTimeToLog = False
    AddMessageTypeToLog = False
    IniFileSectionName = 'Log'
    LogLevel = llTRACE
    isDeleteLogFiles = False
    StoreLogFileDays = 0
    isShowMessageOnError = False
    isFileAssigned = False
    Left = 184
    Top = 176
  end
  object ActionList1: TActionList
    Left = 320
    object aSelectFileDir: TAction
      Caption = 'SelectFileDir'
      OnExecute = aSelectFileDirExecute
    end
    object aWriteToLog: TAction
      Caption = 'WriteToLog'
      OnExecute = aWriteToLogExecute
    end
    object aWriteStrings: TAction
      Caption = 'WriteStrings'
      OnExecute = aWriteStringsExecute
    end
    object aSelectFile: TAction
      Caption = 'SelectFile'
      OnExecute = aSelectFileExecute
    end
    object aWriteFromSream: TAction
      Caption = 'SelectFile'
      OnExecute = aWriteFromSreamExecute
    end
    object aWriteFile: TAction
      Caption = 'WriteFile'
      OnExecute = aWriteFileExecute
    end
    object aWriteStream: TAction
      Caption = 'WriteStream'
      OnExecute = aWriteStreamExecute
    end
    object aSelectFileForStream: TAction
      Caption = 'SelectFileForStream'
      OnExecute = aSelectFileForStreamExecute
    end
  end
  object odWriteFromFile: TOpenDialog
    Left = 360
  end
end
