object frmClaim: TfrmClaim
  Left = 0
  Top = 0
  Caption = 'Insurance Claim Handler'
  ClientHeight = 501
  ClientWidth = 801
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 600
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pnlGrid: TPanel
    Left = 0
    Top = 57
    Width = 801
    Height = 444
    Align = alClient
    TabOrder = 0
    object grdMain: TStringGrid
      Left = 1
      Top = 1
      Width = 799
      Height = 442
      Align = alClient
      ColCount = 2
      DefaultColWidth = 80
      DefaultRowHeight = 20
      DrawingStyle = gdsGradient
      FixedCols = 0
      RowCount = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
      ParentFont = False
      PopupMenu = PopupMenu
      TabOrder = 0
      OnMouseUp = grdMainMouseUp
      ColWidths = (
        38
        157)
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 0
    Width = 801
    Height = 57
    Align = alTop
    TabOrder = 1
    DesignSize = (
      801
      57)
    object btnRefresh: TButton
      Left = 611
      Top = 16
      Width = 75
      Height = 25
      Action = actRefresh
      Anchors = [akTop, akRight]
      TabOrder = 1
      TabStop = False
    end
    object btnInsert: TButton
      Left = 27
      Top = 16
      Width = 75
      Height = 25
      Action = actInsert
      TabOrder = 0
      TabStop = False
    end
    object btnSettings: TButton
      Left = 699
      Top = 16
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Settings'
      TabOrder = 2
      TabStop = False
      OnClick = btnSettingsClick
    end
  end
  object ActionList: TActionList
    Left = 320
    Top = 104
    object actDelete: TAction
      Caption = 'Delete Claim'
      ShortCut = 46
      OnExecute = actDeleteExecute
    end
    object actEdit: TAction
      Caption = 'Edit Claim'
      ShortCut = 115
      OnExecute = actEditExecute
    end
    object actRefresh: TAction
      Caption = 'Refresh'
      ShortCut = 116
      OnExecute = actRefreshExecute
    end
    object actInsert: TAction
      Caption = 'New Claim'
      ShortCut = 45
      OnExecute = actInsertExecute
    end
  end
  object PopupMenu: TPopupMenu
    AutoPopup = False
    TrackButton = tbLeftButton
    Left = 408
    Top = 104
    object Delete1: TMenuItem
      Action = actDelete
    end
    object Edit1: TMenuItem
      Action = actEdit
    end
  end
end
