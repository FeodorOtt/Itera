object frmClaimEdit: TfrmClaimEdit
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Claim Edit'
  ClientHeight = 373
  ClientWidth = 369
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlGrid: TPanel
    Left = 0
    Top = 0
    Width = 369
    Height = 313
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 36
      Top = 25
      Width = 11
      Height = 13
      Caption = 'ID'
    end
    object Label2: TLabel
      Left = 36
      Top = 64
      Width = 27
      Height = 13
      Caption = 'Name'
    end
    object Label3: TLabel
      Left = 36
      Top = 261
      Width = 24
      Height = 13
      Caption = 'Type'
    end
    object Label4: TLabel
      Left = 36
      Top = 103
      Width = 55
      Height = 13
      Caption = 'Gross Claim'
    end
    object Label5: TLabel
      Left = 36
      Top = 143
      Width = 50
      Height = 13
      Caption = 'Deductible'
    end
    object Label6: TLabel
      Left = 36
      Top = 182
      Width = 45
      Height = 13
      Caption = 'Net Claim'
    end
    object Label7: TLabel
      Left = 36
      Top = 221
      Width = 22
      Height = 13
      Caption = 'Year'
    end
    object lbID: TLabel
      Left = 108
      Top = 25
      Width = 3
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtName: TEdit
      Left = 108
      Top = 57
      Width = 220
      Height = 21
      TabOrder = 0
    end
    object edtGrossClaim: TEdit
      Left = 108
      Top = 97
      Width = 220
      Height = 21
      TabOrder = 1
      Text = '0'
      OnChange = edtGrossClaimChange
      OnExit = edtGrossClaimExit
      OnKeyPress = edtGrossClaimKeyPress
    end
    object edtDeductible: TEdit
      Left = 108
      Top = 137
      Width = 220
      Height = 21
      TabOrder = 2
      Text = '0'
      OnChange = edtGrossClaimChange
      OnExit = edtGrossClaimExit
      OnKeyPress = edtGrossClaimKeyPress
    end
    object cbTypeName: TComboBox
      Left = 108
      Top = 258
      Width = 220
      Height = 21
      TabOrder = 5
      OnExit = cbTypeNameExit
    end
    object edtNetClaim: TEdit
      Left = 108
      Top = 179
      Width = 220
      Height = 21
      TabStop = False
      Enabled = False
      ReadOnly = True
      TabOrder = 3
      Text = '0'
    end
    object dtpYear: TDateTimePicker
      Left = 108
      Top = 221
      Width = 220
      Height = 21
      Date = 43686.000000000000000000
      Format = 'yyyy'
      Time = 43686.000000000000000000
      DateMode = dmUpDown
      TabOrder = 4
      OnChange = dtpYearChange
      OnExit = dtpYearChange
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 313
    Width = 369
    Height = 60
    Align = alClient
    TabOrder = 1
    object btnOk: TButton
      Left = 72
      Top = 18
      Width = 75
      Height = 25
      Caption = 'Save'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 217
      Top = 18
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
