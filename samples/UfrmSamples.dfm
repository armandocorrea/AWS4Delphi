object frmSamples: TfrmSamples
  Left = 0
  Top = 0
  Caption = 'Samples - AWS4Delphi - by Armando Neto'
  ClientHeight = 421
  ClientWidth = 776
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 296
    Top = 289
    Width = 474
    Height = 82
    Caption = 'AWS4DELPHI'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -73
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object Label14: TLabel
    Left = 479
    Top = 372
    Width = 109
    Height = 31
    Caption = 'SAMPLE'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -27
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 281
    Height = 254
    Caption = 'SMS - Pinpoint'
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 105
      Width = 54
      Height = 13
      Caption = 'Destination'
    end
    object Label2: TLabel
      Left = 11
      Top = 62
      Width = 42
      Height = 13
      Caption = 'Message'
    end
    object Label3: TLabel
      Left = 11
      Top = 21
      Width = 59
      Height = 13
      Caption = 'Region AWS'
    end
    object Label4: TLabel
      Left = 90
      Top = 21
      Width = 33
      Height = 13
      Caption = 'App ID'
    end
    object edtDestination: TEdit
      Left = 11
      Top = 122
      Width = 145
      Height = 21
      TabOrder = 3
      Text = '+5518999999999'
    end
    object edtMessage: TEdit
      Left = 11
      Top = 78
      Width = 261
      Height = 21
      TabOrder = 2
      Text = 'Hello World!!!'
    end
    object btnSendSMS: TButton
      Left = 11
      Top = 219
      Width = 261
      Height = 25
      Caption = 'Send SMS'
      TabOrder = 7
      OnClick = btnSendSMSClick
    end
    object edtRegion: TEdit
      Left = 11
      Top = 37
      Width = 73
      Height = 21
      TabOrder = 0
      Text = 'sa-east-1'
    end
    object edtAppId: TEdit
      Left = 90
      Top = 37
      Width = 182
      Height = 21
      TabOrder = 1
    end
    object btnAddPhone: TButton
      Left = 162
      Top = 120
      Width = 54
      Height = 25
      Caption = 'Add'
      TabOrder = 4
      OnClick = btnAddPhoneClick
    end
    object lstDestinations: TListBox
      Left = 11
      Top = 151
      Width = 261
      Height = 62
      TabStop = False
      ItemHeight = 13
      TabOrder = 6
    end
    object btnDelDestination: TButton
      Left = 218
      Top = 120
      Width = 54
      Height = 25
      Caption = 'Del'
      TabOrder = 5
      TabStop = False
      OnClick = btnDelDestinationClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 295
    Top = 8
    Width = 474
    Height = 254
    Caption = 'Email - SES'
    TabOrder = 1
    object Label13: TLabel
      Left = 15
      Top = 106
      Width = 71
      Height = 13
      Caption = 'Email Recipient'
    end
    object Label12: TLabel
      Left = 15
      Top = 62
      Width = 42
      Height = 13
      Caption = 'Message'
    end
    object Label11: TLabel
      Left = 334
      Top = 21
      Width = 36
      Height = 13
      Caption = 'Subject'
    end
    object Label10: TLabel
      Left = 96
      Top = 21
      Width = 61
      Height = 13
      Caption = 'Email Sender'
    end
    object Label9: TLabel
      Left = 15
      Top = 21
      Width = 59
      Height = 13
      Caption = 'Region AWS'
    end
    object Label8: TLabel
      Left = 253
      Top = 106
      Width = 41
      Height = 13
      Caption = 'File Path'
    end
    object edtEmailRecipient: TEdit
      Left = 15
      Top = 122
      Width = 151
      Height = 21
      TabOrder = 4
    end
    object edtMessageEmail: TEdit
      Left = 15
      Top = 78
      Width = 449
      Height = 21
      TabOrder = 3
      Text = 'Hello World!!!'
    end
    object edtSubject: TEdit
      Left = 334
      Top = 37
      Width = 130
      Height = 21
      TabOrder = 2
    end
    object edtEmailSender: TEdit
      Left = 96
      Top = 37
      Width = 233
      Height = 21
      TabOrder = 1
    end
    object edtRegionAWSEmail: TEdit
      Left = 15
      Top = 37
      Width = 75
      Height = 21
      TabOrder = 0
      Text = 'sa-east-1'
    end
    object btnSendEmailWithFile: TButton
      Left = 253
      Top = 217
      Width = 211
      Height = 25
      Caption = 'Send With Attach'
      TabOrder = 12
      OnClick = btnSendEmailWithFileClick
    end
    object btnSendEmail: TButton
      Left = 15
      Top = 217
      Width = 232
      Height = 25
      Caption = 'Send Without Attach'
      TabOrder = 11
      OnClick = btnSendEmailClick
    end
    object btnSearchFile: TButton
      Left = 253
      Top = 121
      Width = 170
      Height = 23
      Caption = 'Search File...'
      TabOrder = 8
      OnClick = btnSearchFileClick
    end
    object btnAddRecipient: TButton
      Left = 173
      Top = 120
      Width = 34
      Height = 25
      Caption = 'Add'
      TabOrder = 5
      OnClick = btnAddRecipientClick
    end
    object lstRecipient: TListBox
      Left = 15
      Top = 149
      Width = 232
      Height = 62
      TabStop = False
      ItemHeight = 13
      TabOrder = 7
    end
    object lstFilePath: TListBox
      Left = 253
      Top = 149
      Width = 211
      Height = 62
      TabStop = False
      ItemHeight = 13
      TabOrder = 10
    end
    object btnDelRecipient: TButton
      Left = 209
      Top = 120
      Width = 38
      Height = 25
      Caption = 'Del'
      TabOrder = 6
      TabStop = False
      OnClick = btnDelRecipientClick
    end
    object btnDelFile: TButton
      Left = 426
      Top = 121
      Width = 38
      Height = 23
      Caption = 'Del'
      TabOrder = 9
      TabStop = False
      OnClick = btnDelFileClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 268
    Width = 281
    Height = 144
    Caption = 'S3'
    TabOrder = 2
    object Label6: TLabel
      Left = 11
      Top = 19
      Width = 59
      Height = 13
      Caption = 'Region AWS'
    end
    object Label7: TLabel
      Left = 90
      Top = 19
      Width = 62
      Height = 13
      Caption = 'Bucket Name'
    end
    object Label15: TLabel
      Left = 11
      Top = 63
      Width = 41
      Height = 13
      Caption = 'File Path'
    end
    object btnSearchFileS3: TButton
      Left = 248
      Top = 78
      Width = 24
      Height = 23
      Caption = '...'
      TabOrder = 3
      TabStop = False
      OnClick = btnSearchFileS3Click
    end
    object btnSendFile: TButton
      Left = 11
      Top = 108
      Width = 103
      Height = 25
      Caption = 'Send'
      TabOrder = 4
      OnClick = btnSendFileClick
    end
    object btnSendFileMP: TButton
      Left = 120
      Top = 108
      Width = 152
      Height = 25
      Caption = 'Send MP'
      TabOrder = 5
      OnClick = btnSendFileMPClick
    end
    object edtRegionS3: TEdit
      Left = 11
      Top = 35
      Width = 73
      Height = 21
      TabOrder = 0
      Text = 'sa-east-1'
    end
    object edtBucketName: TEdit
      Left = 90
      Top = 35
      Width = 182
      Height = 21
      TabOrder = 1
    end
    object edtFilePath: TEdit
      Left = 11
      Top = 79
      Width = 234
      Height = 21
      TabOrder = 2
    end
  end
  object FileOpenDialog: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = []
    Left = 304
    Top = 261
  end
end
